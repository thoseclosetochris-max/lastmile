"""Optional opportunity discovery modules."""

from bellingham_assistance_finder.opportunities.grants import search_grants_opportunities
from bellingham_assistance_finder.opportunities.sam import search_sam_opportunities

__all__ = ["search_sam_opportunities", "search_grants_opportunities"]
