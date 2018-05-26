Rails.application.routes.draw do
  resources :stations
  get '/login', "sessions#new"
  post '/login', "sessions#create"
  delete '/logout', "sessions#destroy"
  root "homepage#index"
  resources :users, only: [:new, :create, :index]
end
