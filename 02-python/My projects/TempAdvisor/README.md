# TempAdvisor — Practical Weather Advice

A small command-line utility that looks up the current temperature for a city and returns a short, general advice paragraph  about how to prepare for the conditions.

> This project builds on my existing temperature-detection code (geocoding + Open-Meteo). It adds a human-friendly advice layer that maps temperature ranges to concise guidance.

---

## Features

- Resolve a city name to coordinates using **geopy** (Nominatim).
- Fetch the current temperature from the Open-Meteo API via `openmeteo_requests`.
- Return a short, general paragraph of advice based on the temperature.

---
## Requirements

- Python 3.8+
- `openmeteo_requests`
- `geopy`

# create  virtualenv
python -m venv .venv

# activate virtualenv
source .venv/bin/activate  # Windows: .venv\Scripts\activate


# install dependencies
pip install -r requirements.txt


# run the CLI (interactive mode)
python TempAdvisor.py
