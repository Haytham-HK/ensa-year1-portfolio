"""
weather_cli.py
Author: Haytham HK
Date: 2025-09-21
"""
import openmeteo_requests
from geopy.geocoders import Nominatim

def get_cordinates(city):
    geolocator = Nominatim(user_agent="Haytham-HK")
    location = geolocator.geocode(city)
    lat = location.latitude
    lon = location.longitude
    return(lat,lon)


def get_tempature(lat,long):
    
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


city = input("Enter your city name: ")
lat , long =  get_cordinates(city)
c_temp =  get_tempature(lat,long)
print(f"The current tempature is : {c_temp}")
