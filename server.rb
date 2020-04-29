require 'bundler' ; Bundler.require 
require 'erb'

# By default Sinatra will return the string as the response.
get '/' do
    erb :game
end