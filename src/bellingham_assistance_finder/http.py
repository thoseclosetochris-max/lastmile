from __future__ import annotations

import time
from dataclasses import dataclass
from typing import Any

import requests


@dataclass
class BackoffConfig:
    max_retries: int = 5
    base_delay: float = 1.0
    max_delay: float = 30.0


def request_with_backoff(
    method: str,
    url: str,
    *,
    session: requests.Session | None = None,
    backoff: BackoffConfig | None = None,
    timeout: float = 30,
    **kwargs: Any,
) -> requests.Response:
    client = session or requests.Session()
    config = backoff or BackoffConfig()
    attempt = 0
    while True:
        response = client.request(method, url, timeout=timeout, **kwargs)
        if response.status_code != 429:
            response.raise_for_status()
            return response
        if attempt >= config.max_retries:
            response.raise_for_status()
            return response
        delay = min(config.base_delay * (2**attempt), config.max_delay)
        retry_after = response.headers.get("Retry-After")
        if retry_after and retry_after.isdigit():
            delay = max(delay, float(retry_after))
        time.sleep(delay)
        attempt += 1
