require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

@pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
@gmaps_key = ENV.fetch("GMAPS_KEY")
@openai_key = ENV.fetch("OPENAI_API_KEY")

get("/") do

  erb(:main)

end

get("/umbrella") do

  erb(:umbrella)

end

get("/process_umbrella") do

  @location = params.fetch("user_location")
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
