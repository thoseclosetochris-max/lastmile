from __future__ import annotations

import csv
import json
import zipfile
from pathlib import Path
from typing import Any, Iterable

import requests

from bellingham_assistance_finder.config import Config
from bellingham_assistance_finder.http import request_with_backoff
from bellingham_assistance_finder.normalize import normalize_listing
from bellingham_assistance_finder.schemas import AssistanceListing


def fetch_metadata(config: Config, session: requests.Session | None = None) -> dict[str, Any]:
    response = request_with_backoff(
        "GET",
        config.sam_assistance_metadata_url,
        session=session,
        params={"format": "json"},
    )
    return response.json()


def _extract_downloads(metadata: dict[str, Any]) -> list[dict[str, str]]:
    candidates = []
    for key in ("files", "downloads", "dataFiles"):
        value = metadata.get(key)
        if isinstance(value, list):
            candidates.extend(value)
    if not candidates:
        return []
    downloads: list[dict[str, str]] = []
    for item in candidates:
        if not isinstance(item, dict):
            continue
        url = item.get("url") or item.get("downloadURL") or item.get("link")
        name = item.get("name") or item.get("fileName") or "assistance_listings"
        if url:
            downloads.append({"url": url, "name": name})
    return downloads


def download_extracts(config: Config, session: requests.Session | None = None) -> list[Path]:
    metadata = fetch_metadata(config, session=session)
    downloads = _extract_downloads(metadata)
    if not downloads:
        raise ValueError("No download links found in metadata response.")

    config.data_dir.mkdir(parents=True, exist_ok=True)
    saved_paths: list[Path] = []
    for item in downloads:
        url = item["url"]
        filename = Path(item["name"]).name
        destination = config.data_dir / filename
        response = request_with_backoff("GET", url, session=session, stream=True)
        with destination.open("wb") as handle:
            for chunk in response.iter_content(chunk_size=1024 * 1024):
                if chunk:
                    handle.write(chunk)
        saved_paths.append(destination)
    return saved_paths


def _load_json_records(path: Path) -> Iterable[dict[str, Any]]:
    with path.open("r", encoding="utf-8") as handle:
        payload = json.load(handle)
    if isinstance(payload, list):
        return payload
    if isinstance(payload, dict):
        for key in ("data", "records", "results"):
            if isinstance(payload.get(key), list):
                return payload[key]
    return []


def _load_csv_records(path: Path) -> Iterable[dict[str, Any]]:
    with path.open("r", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return list(reader)


def _extract_zip(path: Path, target_dir: Path) -> list[Path]:
    extracted: list[Path] = []
    with zipfile.ZipFile(path, "r") as zf:
        for name in zf.namelist():
            target_path = target_dir / Path(name).name
            with zf.open(name) as source, target_path.open("wb") as dest:
                dest.write(source.read())
            extracted.append(target_path)
    return extracted


def load_records_from_file(path: Path, working_dir: Path) -> list[AssistanceListing]:
    if not path.exists():
        raise FileNotFoundError(f"File not found: {path}")
    working_dir.mkdir(parents=True, exist_ok=True)

    files_to_read = [path]
    if path.suffix.lower() == ".zip":
        files_to_read = _extract_zip(path, working_dir)

    listings: list[AssistanceListing] = []
    for file_path in files_to_read:
        suffix = file_path.suffix.lower()
        if suffix in (".json", ".jsonl"):
            records = _load_json_records(file_path)
        elif suffix in (".csv", ".tsv"):
            records = _load_csv_records(file_path)
        else:
            continue
        for record in records:
            if not isinstance(record, dict):
                continue
            listings.append(normalize_listing(record))
    return listings
