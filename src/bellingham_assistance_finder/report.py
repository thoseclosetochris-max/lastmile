from __future__ import annotations

import json
from dataclasses import asdict
from datetime import datetime
from pathlib import Path
from typing import Any

from bellingham_assistance_finder.rank import RankedListing


def build_report_payload(
    ranked: list[RankedListing],
    metadata: dict[str, Any] | None = None,
) -> dict[str, Any]:
    return {
        "generated_at": datetime.utcnow().isoformat() + "Z",
        "metadata": metadata or {},
        "results": [
            {
                "score": item.score,
                "explanation": item.explanation,
                "listing": asdict(item.listing),
            }
            for item in ranked
        ],
    }


def write_report(output_path: Path, payload: dict[str, Any]) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    if output_path.suffix.lower() == ".json":
        with output_path.open("w", encoding="utf-8") as handle:
            json.dump(payload, handle, indent=2)
        return

    markdown_path = output_path
    json_path = output_path.with_suffix(".json")
    with json_path.open("w", encoding="utf-8") as handle:
        json.dump(payload, handle, indent=2)

    with markdown_path.open("w", encoding="utf-8") as handle:
        handle.write("# Bellingham Assistance Finder Report\n\n")
        handle.write(f"Generated: {payload['generated_at']}\n\n")
        results = payload.get("results", [])
        for idx, item in enumerate(results, start=1):
            listing = item["listing"]
            handle.write(f"## {idx}. {listing.get('title', 'Untitled')}\n")
            handle.write(f"- ALN: {listing.get('listing_number')}\n")
            handle.write(f"- Agency: {listing.get('agency')}\n")
            handle.write(f"- Score: {item.get('score')}\n")
            handle.write(f"- Explanation: {item.get('explanation')}\n")
            if listing.get("website"):
                handle.write(f"- Website: {listing.get('website')}\n")
            if listing.get("description"):
                handle.write(f"\n{listing.get('description')}\n")
            handle.write("\n")
