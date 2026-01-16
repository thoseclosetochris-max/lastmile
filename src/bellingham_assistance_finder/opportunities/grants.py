from __future__ import annotations

from typing import Any

import requests

from bellingham_assistance_finder.http import request_with_backoff


def search_grants_opportunities(
    api_key: str | None,
    keywords: list[str],
    *,
    base_url: str = "https://api.grants.gov/v1/opportunities/search",
    limit: int = 25,
) -> list[dict[str, Any]]:
    if not api_key:
        return []

    payload = {
        "keyword": " ".join(keywords),
        "rows": limit,
        "apiKey": api_key,
    }

    response = request_with_backoff(
        "POST",
        base_url,
        json=payload,
        session=requests.Session(),
    )
    data = response.json()
    results = data.get("opportunities") or data.get("results") or []
    if isinstance(results, list):
        return results
    return []
