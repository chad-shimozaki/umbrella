
require "http"
require "json"
require "dotenv/load"
require "active_support/all"
require "awesome_print"
require "pry-byebug"


# user response required
puts "Where are you located?"

#save repsonse
user_location = gets.chomp
# user_location = "Toronto"
puts "Checking the weather at #{user_location.titlecase}..."

#compile GMAPS URL
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# getting response from GMAP, turning it into String, and converting JSON into Hash
resp = HTTP.get(maps_url)
raw_response = resp.to_s
parsed_response = JSON.parse(raw_response)

#digging through response from GMAMPS to get lat & lng
results = parsed_response.fetch("results")
first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")

lat = loc.fetch("lat")
lng = loc.fetch("lng")
puts "Your coordinates are #{lat}, #{lng}."

# compile PIRATE_WEATHER URL
pirate_weather_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_WEATHER_KEY") + "/" + lat.to_s + "," + lng.to_s

# getting response from Pirate Weather, turning it into String, and converting JSON into Hash
weather_resp = HTTP.get(pirate_weather_url)
raw_weather_response = weather_resp.to_s
parsed_weather_response = JSON.parse(raw_weather_response)

#digging through response from GMAMPS to get current weather
current = parsed_weather_response.fetch("currently")
temp = current.fetch("temperature")
puts "It is currently #{temp}°F."

#next hour weather
hourly = parsed_weather_response.fetch("hourly")
next_hour = hourly.fetch("summary")
puts "Next Hour Conditions: #{next_hour}"
