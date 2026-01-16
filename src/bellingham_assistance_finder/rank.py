from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from bellingham_assistance_finder.schemas import AssistanceListing


@dataclass
class RankedListing:
    listing: AssistanceListing
    score: float
    explanation: str


def _score_text(text: str, keywords: list[str]) -> tuple[float, list[str]]:
    score = 0.0
    matched: list[str] = []
    lower = text.lower()
    for keyword in keywords:
        if keyword.lower() in lower:
            score += 1.0
            matched.append(keyword)
    return score, matched


def rank_listings(
    listings: list[AssistanceListing],
    profile: dict[str, Any],
) -> list[RankedListing]:
    keywords = profile.get("keywords", [])
    eligibility_keywords = profile.get("eligibility_keywords", [])
    industry_keywords = profile.get("industry_keywords", [])

    ranked: list[RankedListing] = []
    for listing in listings:
        score = 0.0
        explanation_parts: list[str] = []

        text_block = " ".join([
            listing.title,
            listing.description,
            listing.agency,
            listing.eligibility or "",
        ])

        base_score, matched = _score_text(text_block, keywords)
        score += base_score
        if matched:
            explanation_parts.append(f"Matched profile keywords: {', '.join(sorted(set(matched)))}")

        industry_score, industry_matched = _score_text(text_block, industry_keywords)
        score += industry_score * 0.75
        if industry_matched:
            explanation_parts.append(
                f"Matched industry keywords: {', '.join(sorted(set(industry_matched)))}"
            )

        eligibility_score, eligibility_matched = _score_text(
            listing.eligibility or "", eligibility_keywords
        )
        score += eligibility_score * 1.5
        if eligibility_matched:
            explanation_parts.append(
                f"Eligibility signals: {', '.join(sorted(set(eligibility_matched)))}"
            )

        if not explanation_parts:
            explanation_parts.append("No direct keyword matches; ranked based on baseline relevance.")

        ranked.append(
            RankedListing(
                listing=listing,
                score=score,
                explanation=" ".join(explanation_parts),
            )
        )

    ranked.sort(key=lambda item: item.score, reverse=True)
    return ranked
