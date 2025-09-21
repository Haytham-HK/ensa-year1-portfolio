A small Python CLI I built to practice working with web APIs and geocoding.
Enter a city name (e.g. `Casablanca`) and the CLI converts the city to latitude/longitude using Geopy (Nominatim) and then requests the current temperature from the free Open-Meteo API.



# Weather CLI

A small Python CLI I built to practice working with web APIs and geocoding.

## What it does
Enter a city name (e.g. `Casablanca`) and the CLI converts the city to latitude/longitude using Geopy (Nominatim) and then requests the current temperature from the free Open-Meteo API.

## Quickstart
\`\`\`bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
python weather_cli.py "New York"  # or run interactively
\`\`\`

## How I built it
- Researched scraping vs APIs; chose Open-Meteo because it's free and simple.
- Used `geopy` + Nominatim for geocoding.
- Added basic error handling and a small unit test (optional).
