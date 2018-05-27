Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get "/:station-name", to: redirect("/%{station-name}")

  get '/dashboard', to: 'users#show'
  root "homepages#index"

  resources :stations
  resources :users, only: [:new, :create, :show, :index]
  resources :trips, only: [:show, :index]

<<<<<<< HEAD
  namespace :admin do
    resources :stations
    resources :trips
=======
  resources :stations, shallow: true do
    resources :trips, only: [:show, :index]
>>>>>>> Implements visitor station show WIP
  end

  resources :orders, only: [:new, :create, :show]

  get '/bike-shop', to: 'items#index'
  resources :items, only: [:show]

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'

  match '*path', to: 'unknowns#index', via: :all
end
