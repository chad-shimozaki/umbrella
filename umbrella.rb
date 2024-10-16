
require "http"
require "json"
require "dotenv/load"
require "json"

pp "Where are you located?"

user_location = gets.chomp

# user_location = "Chicago"

# pireate_weather_url = https://api.pirateweather.net/forecast/REPLACE_THIS_PATH_SEGMENT_WITH_YOUR_API_TOKEN/41.8887,-87.6355

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")
first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")

lat = loc.fetch("lat")
lng = loc.fetch("lng")

pp lat
pp lng
