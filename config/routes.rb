Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
<<<<<<< HEAD
<<<<<<< HEAD
=======
  get '/dashboard', to: "users#show"

>>>>>>> Fixes routes
  get "/:station-name", to: redirect("/%{station-name}")

  get '/dashboard', to: 'users#show'
  root "homepages#index"
=======
  get "/:station-name", to: redirect("/%{station-name}")
  root "homepages#index"
  resources :users, only: [:new, :create, :show, :index]
>>>>>>> ca30eacf08dcee70761cbb748003856e1b05830b

  resources :stations
  resources :users, only: [:new, :create, :show, :index]
  resources :trips, only: [:show, :index]

<<<<<<< HEAD
<<<<<<< HEAD
  namespace :admin do
    resources :stations
    resources :trips
=======
  resources :stations, shallow: true do
    resources :trips, only: [:show, :index]
<<<<<<< HEAD
>>>>>>> Implements visitor station show WIP
=======
>>>>>>> ca30eacf08dcee70761cbb748003856e1b05830b
  end
=======
  resources :stations

  resources :trips, only: [:show, :index]

<<<<<<< HEAD
>>>>>>> 22-visitor-trip-index WIP
=======
  namespace :admin do
    resources :stations
    resources :trips
  end 

>>>>>>> Fixes routes

  resources :orders, only: [:new, :create, :show]

  get '/bike-shop', to: 'items#index'
  resources :items, only: [:show]

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'

  match '*path', to: 'unknowns#index', via: :all
end
