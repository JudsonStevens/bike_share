Rails.application.routes.draw do
  get '/login', "sessions#new"
  post '/login', "sessions#create"
  delete '/logout', "sessions#destroy"
  root "homepage#index"

end
