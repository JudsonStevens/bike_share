Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  root "homepages#index"

  resources :users, only: [:new, :create, :index, :show]

  resources :stations

<<<<<<< HEAD
  resources :stations, shallow: true do
    resources :trips, only: [:show]
  end
  
=======
  resources :trips, only: [:show, :index]

>>>>>>> finished testing that admin can see edit/delete while user cannot
  namespace :admin do
    resources :stations
    resources :trips
  end

  get '/bike-shop', to: 'items#index'
  resources :items, only: [:show]

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
end
