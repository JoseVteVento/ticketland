require 'rubygems'
require 'sinatra'
require 'pony'

TITLE = "Ticketland | "
tickets_list = []


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
	@id_ticket = Time.now.to_i
	@name = params[:name]
	@email = params[:email]
	@phone = params[:phone]
	@film = params[:film]
	@price = params[:price]
	erb :confirm	
end

post '/confirm/:id_ticket' do
		
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
    Pony.mail(:subject=> 'Confirmación compra de Ticket ' , 
    	:to => "#{params[:email]}", 
    	:body => "Gracias por comprar a través de Ticketland. El código de su entrada es #{params[:id_ticket]}" )

	@title = TITLE << "Compra confirmada"
	@id_ticket = params[:id_ticket]
	@name = params[:name]
	@email = params[:email]
	@phone = params[:phone]
	@film = params[:film]
	@price = params[:price] 
	
	erb :confirmed

end

put '/confirm' do
	#añadir la informacion al array
end

