require 'rubygems'
require 'sinatra'
require 'pony'

class Ticket

	@@tickets_list = []

	def initialize(ticket_code, name, email, phone, film, price)
		@ticket_code = ticket_code,
		@name = name,
		@email = email,
		@phone = phone,
		@film = film,
		@price = price
	end

	def get_ticket_id
		@ticket_code
	end

	def get_name
		@name
	end

	def get_email
		@email
	end

	def get_phone
		@phone
	end

	def get_film
		@film
	end

	def get_price
		@price
	end

	def add_ticket
		@@tickets_list << [@ticket_code, @name, @email, @phone, @film, @price]
	end

	def get_tickets_list
		@@tickets_list
	end
end



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

	@ticket = Ticket.new(params[:id_ticket], params[:name], params[:email], params[:phone], params[:film], params[:price])
	
	erb :confirmed
end

post '/show' do	
	@tickets=Ticket.get_tickets_list
	erb :show
end
