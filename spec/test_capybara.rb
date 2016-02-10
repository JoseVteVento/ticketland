require 'capybara/rspec'
require './ticketland'


Capybara.app = Sinatra::Application

describe "testing all routes: ", :type => :feature do
	it "from home page to form" do
		visit '/'
		click_button ('home_button')
		expect(page).to have_content('Seleccione película')
	end

	it 'from form to confirm' do
		visit '/form'
		click_button ('form_button')
		expect(page).to have_content('Código entrada')
	end

	it 'show page return to home page' do
		visit '/review/123456789/ted/email@ted/555123456/peli/7.5'
		click_button ('show_button')
		expect(page).to have_title('Ticketland | Home')
	end

	xit 'from home through form, confirm and confirmed and ending in home' do
		visit '/'
		click_button ('home_button')
		click_button ('form_button')
		click_button ('confirm_button')
		click_button ('confirm_back_button')
		expect(page).to have_title('Home')
	end
end