Rails.application.routes.draw do
  get 'testis/mudici'

  root 'scraper#show_form'
  post 'scraper/store', to: 'scraper#store'
  get 'scraper/testis', to: 'scraper#testis'
end
