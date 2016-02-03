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