# Bellingham Assistance Finder

Bellingham Assistance Finder is a compliant automation to ingest SAM.gov Assistance Listings (ALN/CFDA) data, optionally cross-link active opportunities, and produce a ranked, explainable report for Bellingham Consulting LLC.

> **Important:** Assistance Listings are program descriptions, not guaranteed open funding opportunities. This tool treats them as program intelligence and optionally cross-links active opportunities from SAM.gov and grants.gov when configured.

## Compliance Notes

- Uses official APIs or official data extracts (no scraping).
- Handles 429 responses with exponential backoff.
- Reads API keys from environment variables only.

## Data Sources

- **SAM.gov Data Services – Assistance Listings dataset** (official public dataset used for ingestion). The dataset is available via SAM.gov Data Services and bulk download endpoints: https://api.sam.gov/data-services. This automation can download the latest Assistance Listings extract metadata and files or ingest a manually downloaded file placed in `data/`.
- **SAM.gov Opportunities API** (optional, for active contract opportunities). See: https://sam.gov/api/.
- **grants.gov API** (optional, for active grant opportunities). See: https://www.grants.gov/api/.

## Quick Start

### If you’ve never coded before (simple steps)
1. **Open a terminal**
   - On Windows: open **PowerShell**
   - On macOS: open **Terminal**
2. **Go to the project folder**
   ```bash
   cd /path/to/lastmile
   ```
   Replace `/path/to/lastmile` with the folder where you saved this project.
3. **Create and activate a Python environment**
   ```bash
   python -m venv .venv
   ```
   **Windows (PowerShell):**
   ```bash
   .venv\\Scripts\\Activate.ps1
   ```
   **macOS/Linux:**
   ```bash
   source .venv/bin/activate
   ```
4. **Install the tool**
   ```bash
   pip install -e .
   ```
5. **Run it**
   ```bash
   bafinder ingest --mode download
   bafinder report --output reports/bellingham_report.md
   ```

### Standard Quick Start (for developers)
```bash
python -m venv .venv
source .venv/bin/activate
pip install -e .

# Download and ingest the latest Assistance Listings extract
bafinder ingest --mode download

# Or ingest a manually downloaded extract placed in ./data
bafinder ingest --mode local --file data/assistance_listings.zip

# Rank programs and generate a report
bafinder report --output reports/bellingham_report.md
```

## Environment Variables

- `SAM_API_KEY`: API key for SAM.gov Opportunities API (optional).
- `SAM_DATA_BASE_URL`: Base URL for SAM.gov Data Services (default: `https://api.sam.gov/data-services`).
- `SAM_ASSISTANCE_METADATA_URL`: Override for the Assistance Listings metadata endpoint.
- `GRANTS_API_KEY`: API key for grants.gov (optional).

## Report Output

Reports are written to `reports/` in Markdown and JSON formats, including scoring and explanations for each Assistance Listing.
