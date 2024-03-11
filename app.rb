require "sinatra"
require "sinatra/reloader"

get("/") do

  erb(:main)

end

get("/umbrella") do

  erb(:umbrella)

end

get("/message") do

  erb(:message)

end

get("/chat") do

  erb(:chat)

end
