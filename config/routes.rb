Rails.application.routes.draw do
  root 'scraper#show_form'
  post 'scraper/store', to: 'scraper#store'
  post 'scraper/additional-email', to: 'scraper#additional_email'
end
