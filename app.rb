require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "active_support/all"

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
gmaps_key = ENV.fetch("GMAPS_KEY")
openai_key = ENV.fetch("OPENAI_API_KEY")

get("/") do

  erb(:main)

end

get("/umbrella") do

  erb(:umbrella)

end

post("/process_umbrella") do

  @location = params.fetch("user_location")
  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@location}&key=#{gmaps_key}"
  raw_response = HTTP.get(gmaps_url)
  parsed_response = JSON.parse(raw_response)
  results = parsed_response.fetch("results")
  results_array_to_hash = results.at(0)
  @geometry = results_array_to_hash.fetch("geometry")
  location = @geometry.fetch("location")
  @lat = location.fetch("lat")
  @lng = location.fetch("lng")

  pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{@lat},#{@lng}"
  raw_response = HTTP.get(pirate_weather_url)
  parsed_response = JSON.parse(raw_response)
  @currently_hash = parsed_response.fetch("currently")
  @current_temp = @currently_hash.fetch("temperature")
  @current_summary = @currently_hash.fetch("summary")
  precip_percent = @currently_hash.fetch("precipProbability")
  if precip_percent >= 0.1
    @umbrella_results = "You will need an umbrella today"
  else
    @umbrella_results = "You probably won't need an umbrella today"
  end

  erb(:process_umbrella)

end

get("/message") do

  erb(:message)

end

get("/process_single_message") do

  erb(:process_single_message)

end

get("/chat") do

  erb(:chat)

end
