Rails.application.routes.draw do
  root 'scraper#show_form'
  post '/db', to: 'scraper#db'
end
