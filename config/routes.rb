Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/dashboard', to: 'users#show'
  root "homepages#index"

  resources :users, only: [:new, :create]

  resources :stations

  resources :trips, only: [:show, :index]

  namespace :admin do
    resources :stations
    resources :trips
  end

  get '/bike-shop', to: 'items#index'
  resources :items, only: [:show]

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'

  get '/*path', to: 'unknowns#index'
end
