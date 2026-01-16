from __future__ import annotations

from dataclasses import dataclass
from typing import Any


@dataclass
class AssistanceListing:
    listing_number: str
    title: str
    description: str
    agency: str
    last_updated: str | None
    eligibility: str | None
    website: str | None
    raw: dict[str, Any]
