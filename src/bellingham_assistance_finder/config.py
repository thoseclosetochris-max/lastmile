from __future__ import annotations

import json
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Any


PROJECT_ROOT = Path(__file__).resolve().parents[2]


@dataclass(frozen=True)
class Config:
    sam_api_key: str | None
    sam_data_base_url: str
    sam_assistance_metadata_url: str
    grants_api_key: str | None
    data_dir: Path
    reports_dir: Path
    profile_path: Path


def load_company_profile(path: Path) -> dict[str, Any]:
    if not path.exists():
        return {}
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def load_config() -> Config:
    sam_data_base_url = os.getenv("SAM_DATA_BASE_URL", "https://api.sam.gov/data-services")
    sam_assistance_metadata_url = os.getenv(
        "SAM_ASSISTANCE_METADATA_URL",
        f"{sam_data_base_url}/v1/assistance-listings",
    )
    data_dir = Path(os.getenv("DATA_DIR", PROJECT_ROOT / "data"))
    reports_dir = Path(os.getenv("REPORTS_DIR", PROJECT_ROOT / "reports"))
    profile_path = Path(os.getenv("COMPANY_PROFILE", PROJECT_ROOT / "company_profile.json"))

    return Config(
        sam_api_key=os.getenv("SAM_API_KEY"),
        sam_data_base_url=sam_data_base_url,
        sam_assistance_metadata_url=sam_assistance_metadata_url,
        grants_api_key=os.getenv("GRANTS_API_KEY"),
        data_dir=data_dir,
        reports_dir=reports_dir,
        profile_path=profile_path,
    )
