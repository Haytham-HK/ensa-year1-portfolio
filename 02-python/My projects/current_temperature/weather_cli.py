"""
weather_cli.py
Author: Haytham HK
Date: 2025-09-21
"""
import openmeteo_requests
from geopy.geocoders import Nominatim

def get_coordinates(city):
    geolocator = Nominatim(user_agent="Haytham-HK")
    location = geolocator.geocode(city)
    if not location :
        print("could not find coordinates")
        return None, None
    lat = location.latitude
    lon = location.longitude
    return lat,lon


def get_temperature(lat,long):
    if lat is None or long is None:
        return None
    
    try:
        openmeteo = openmeteo_requests.Client()

        url = "https://api.open-meteo.com/v1/forecast"

        params = {
            "latitude": lat,
            "longitude": long,
            "current_weather":"true"
        }

        responses = openmeteo.weather_api(url, params=params) 
        
        response = responses[0] 

        current = response.Current()
        current_temperature = current.Variables(0).Value()

        return current_temperature

    except Exception as error :
        print ("failed to fetch weather data",error)
        return None  


city = input("Enter your city name: ")
lat , long =  get_coordinates(city)
c_temp =  get_temperature(lat,long)

if c_temp is not None :
    print(f"The current temperature in °C is : {c_temp}")
else :
    print("Could not get temperature. Please try again .")   