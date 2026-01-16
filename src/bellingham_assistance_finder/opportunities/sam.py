from __future__ import annotations

from typing import Any

import requests

from bellingham_assistance_finder.http import request_with_backoff


def search_sam_opportunities(
    api_key: str,
    keywords: list[str],
    *,
    base_url: str = "https://api.sam.gov/opportunities/v2/search",
    limit: int = 25,
) -> list[dict[str, Any]]:
    if not api_key:
        return []

    params = {
        "api_key": api_key,
        "limit": limit,
        "keywords": " ".join(keywords),
    }

    response = request_with_backoff("GET", base_url, params=params, session=requests.Session())
    payload = response.json()
    opportunities = payload.get("opportunitiesData") or payload.get("data") or []
    if isinstance(opportunities, list):
        return opportunities
    return []
