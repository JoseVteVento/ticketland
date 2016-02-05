require 'rubygems'
require 'sinatra'
require 'pony'
require './helpers/ticket'

TITLE = "Ticketland | "

get '/' do 
	@title = TITLE << "Home " 
	erb :home	
end

get '/form' do
	@title = TITLE << "Form" 	
	@film_list = ["Star Wars", "Los Odiosos", "La gran apuesta", "La quinta ola"]
	@list_prices = {"Normal" => 6.50, "3D" => 8.50, "Día del espectador" => 5.00}
	erb :form
end

post '/confirm' do	
	@title = TITLE << "Confimación"
	ticket_id = Time.now.to_i
	@ticket = Ticket.new(ticket_id, params[:name], params[:email], params[:phone], params[:film], params[:price])
	@ticket.add_ticket
	erb :confirm	
end

post '/confirm/:id_ticket' do
		@title = TITLE << "Confirmado"

	Pony.options = {
    :from => 'ticketland.herokuapp.com',
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }

  body = "<h2>Gracias por comprar a través de Ticketland</h2></br> 
  			<p>El código de su entrada es #{params[:id_ticket]}</p></br>
  			<a href='https://ticketland.herokuapp.com/review/#{params[:id_ticket]}/#{params[:name]}/#{params[:email]}/#{params[:phone]}/#{params[:film]}/#{params[:price]}'>See your ticket</a>
  			" 
    Pony.mail(:subject=> 'Confirmación compra de Ticket ' , 
    	:to => "#{params[:email]}", 
    	:html_body => body)

	@ticket = Ticket.new(params[:id_ticket], params[:name], params[:email], params[:phone], params[:film], params[:price])
	
	erb :confirmed
end

get '/review/:id/:name/:email/:phone/:film/:price' do	
	@ticket = Ticket.new(params[:id], params[:name], params[:email], params[:phone], params[:film].gsub('+',' '), params[:price])
	erb :show
end