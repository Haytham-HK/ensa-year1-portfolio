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
    

def advice(c_temp):
    if c_temp >= 30:
        return ("Feels very hot and often humid; go for the lightest possible — minimal layers, and focus on staying cool and protected from the sun and heat.")
    elif 25 <= c_temp < 30:
        return ("Warm and comfortable; opt for a single, lightweight layer that lets you stay relaxed in the heat but can be removed if you go indoors into cool air. Aim for an easy, casual look.")
    elif 20 <= c_temp < 25:
        return ("Mild and pleasant; choose light layering so you can adapt through the day.Think balanced, neither too light nor heavy.")
    elif 15 <= c_temp < 20:
        return ("Noticeably cool; use a couple of light-to-medium layers to stay comfortable in a breeze or shade. The overall vibe should be tidy and practical.")
    elif 10 <= c_temp < 15:
        return ("Chilly; go for clearly warming layers with a slightly thicker outer layer — enough to feel comfortably warm while remaining put-together.")
    elif 5 <= c_temp < 10:
        return ("Cold; wear multiple insulating layers with a solid outer layer to block wind and retain warmth. The look should be practical and weather-ready.")
    elif 0 <= c_temp < 5:
        return ("Very cold; use substantial layering with insulating bases and a robust outer layer for protection against biting cold and wind. Focus on warmth and coverage.")
    elif c_temp < 0 :  
        return ("Freezing conditions; plan for heavy insulation with multiple warm layers and a windproof/water-resistant outer system to handle extreme cold. Prioritize protection and functionality first.")
    
city = input("Enter your city name: ")
lat , long =  get_coordinates(city)
c_temp =  get_temperature(lat,long)

if c_temp is not None :
    print(f"The current temperature in °C is : {c_temp}")

    print(f'Advice : {advice(c_temp)}')
else :
    print("Could not get temperature. Please try again .")