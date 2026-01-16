from __future__ import annotations

from typing import Any

from bellingham_assistance_finder.schemas import AssistanceListing


def _first_value(record: dict[str, Any], keys: list[str]) -> str | None:
    for key in keys:
        value = record.get(key)
        if value:
            return str(value)
    return None


def normalize_listing(record: dict[str, Any]) -> AssistanceListing:
    listing_number = _first_value(
        record,
        ["AssistanceListingNumber", "assistance_listing_number", "CFDA", "ALN"],
    )
    title = _first_value(record, ["ProgramTitle", "title", "program_title"]) or ""
    description = _first_value(
        record,
        ["ProgramDescription", "description", "program_description", "Summary"],
    ) or ""
    agency = _first_value(record, ["Agency", "agency", "FederalAgency"]) or ""
    last_updated = _first_value(record, ["LastUpdatedDate", "last_updated", "UpdatedDate"])
    eligibility = _first_value(record, ["Eligibility", "eligibility", "ApplicantEligibility"])
    website = _first_value(record, ["Website", "website", "URL", "ProgramURL"])

    if not listing_number:
        listing_number = "UNKNOWN"

    return AssistanceListing(
        listing_number=listing_number,
        title=title,
        description=description,
        agency=agency,
        last_updated=last_updated,
        eligibility=eligibility,
        website=website,
        raw=record,
    )
