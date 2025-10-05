# Weather CLI

A small Python CLI I built to practice working with web APIs and geocoding.

## What it does
Enter a city name and the CLI converts the city to latitude/longitude using Geopy (Nominatim) and then requests the current temperature from the free Open-Meteo API.

# create  virtualenv
python -m venv .venv

# activate virtualenv
source .venv/bin/activate  # Windows: .venv\Scripts\activate


# install dependencies
pip install -r requirements.txt


# run the CLI (interactive mode)
python weather_cli.py

## How I built it
- Researched scraping vs APIs; chose Open-Meteo because it's free and simple.
- Used `geopy` + Nominatim for geocoding.

