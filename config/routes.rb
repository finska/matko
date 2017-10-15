Rails.application.routes.draw do
	root 'scraper#show_form'
	get 'scraper/:user', to: 'scraper#analyze'
	post 'scraper/store-email', to: 'scraper#store_email'
	post 'scraper/additional-email', to: 'scraper#additional_email'
	post 'tracklift/request', to: 'track_lift#read_request'
	post '/shipments', to: 'application#shipments_request'
end
