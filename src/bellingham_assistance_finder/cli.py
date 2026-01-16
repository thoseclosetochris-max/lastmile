from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from bellingham_assistance_finder.config import load_company_profile, load_config
from bellingham_assistance_finder.ingest import download_extracts, load_records_from_file
from bellingham_assistance_finder.opportunities import (
    search_grants_opportunities,
    search_sam_opportunities,
)
from bellingham_assistance_finder.rank import rank_listings
from bellingham_assistance_finder.report import build_report_payload, write_report
from bellingham_assistance_finder.schemas import AssistanceListing


def _save_normalized(path: Path, listings: list[AssistanceListing]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    payload = [listing.__dict__ for listing in listings]
    with path.open("w", encoding="utf-8") as handle:
        json.dump(payload, handle, indent=2)


def _load_normalized(path: Path) -> list[AssistanceListing]:
    if not path.exists():
        raise FileNotFoundError(f"Normalized file not found: {path}")
    with path.open("r", encoding="utf-8") as handle:
        payload = json.load(handle)
    listings: list[AssistanceListing] = []
    for record in payload:
        listings.append(AssistanceListing(**record))
    return listings


def ingest_command(args: argparse.Namespace) -> int:
    config = load_config()
    session = None

    if args.mode == "download":
        try:
            downloaded = download_extracts(config, session=session)
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to download extracts: {exc}", file=sys.stderr)
            return 1
        data_file = downloaded[0]
    else:
        data_file = Path(args.file) if args.file else None
        if not data_file:
            print("--file is required in local mode.", file=sys.stderr)
            return 1

    listings = load_records_from_file(data_file, config.data_dir / "working")
    normalized_path = config.data_dir / "assistance_listings_normalized.json"
    _save_normalized(normalized_path, listings)
    print(f"Saved {len(listings)} listings to {normalized_path}")
    return 0


def report_command(args: argparse.Namespace) -> int:
    config = load_config()
    profile = load_company_profile(config.profile_path)
    normalized_path = Path(args.input) if args.input else config.data_dir / "assistance_listings_normalized.json"

    listings = _load_normalized(normalized_path)
    ranked = rank_listings(listings, profile)

    opportunities = {
        "sam_opportunities": search_sam_opportunities(
            config.sam_api_key or "",
            keywords=profile.get("keywords", []),
        ),
        "grants_gov": search_grants_opportunities(
            config.grants_api_key,
            keywords=profile.get("keywords", []),
        ),
    }

    report_payload = build_report_payload(
        ranked,
        metadata={
            "company": profile.get("company_name", ""),
            "opportunities": opportunities,
        },
    )

    output_path = Path(args.output) if args.output else config.reports_dir / "bellingham_report.md"
    write_report(output_path, report_payload)
    print(f"Report written to {output_path}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Bellingham Assistance Finder")
    subparsers = parser.add_subparsers(dest="command", required=True)

    ingest_parser = subparsers.add_parser("ingest", help="Ingest SAM.gov Assistance Listings")
    ingest_parser.add_argument(
        "--mode",
        choices=["download", "local"],
        default="download",
        help="Download latest extract or read local file.",
    )
    ingest_parser.add_argument("--file", help="Local file path for --mode local.")
    ingest_parser.set_defaults(func=ingest_command)

    report_parser = subparsers.add_parser("report", help="Generate ranked report")
    report_parser.add_argument("--input", help="Normalized listings JSON file.")
    report_parser.add_argument("--output", help="Report output path (Markdown or JSON).")
    report_parser.set_defaults(func=report_command)

    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    sys.exit(args.func(args))
