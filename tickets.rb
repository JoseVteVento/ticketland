
require 'rubygems'
require 'sinatra'

get '/' do 
	@title = "Ticketland | Home" 
	erb :home	
end
