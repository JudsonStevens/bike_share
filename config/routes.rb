Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get "/:station-name", to: redirect("/%{station-name}")


  get '/dashboard', to: 'users#show'
  get '/admin/dashboard', to: 'admin/dashboards#show'

  root "homepages#index"

  resources :users, only: [:new, :create]

  resources :stations, except: [:show]

  resources :trips, only: [:show, :index]


  resources :stations, except: [:show]

  resources :trips, only: [:show, :index]


  namespace :admin do
    resources :stations
    resources :trips
    resources :items
    get '/bike-shop', to: 'items#index'
  end

  resources :items, only: [:show]
  resources :orders, only: [:new, :create, :show]

  get '/bike-shop', to: 'items#index'


  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'

  resources :stations, only: [:show]

  match '*path', to: 'unknowns#index', via: :all

end
