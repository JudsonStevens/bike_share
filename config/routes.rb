Rails.application.routes.draw do
  root "homepages#index"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'

  get '/admin/dashboard', to: 'admin/dashboards#show'
  get '/admin/bike-shop/new', to: 'admin/items#new'

  resources :users, only: [:new, :create, :edit, :update]

  get "/:station-name", to: redirect("/%{station-name}")
  resources :stations, only: [:index, :show]

  resources :trips, only: [:show, :index]

  resources :items, only: [:show]
  get '/bike-shop', to: 'items#index'

  resources :orders, only: [:new, :create, :show]

  namespace :admin do
    resources :stations, only: [:new, :create, :destroy, :edit, :update]
    resources :trips
    resources :items
    resources :orders, only: [:edit]
    get '/bike-shop', to: 'items#index'
    get '/dashboard', to: 'dashboards#show'
  end

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'

  get '/stations-dashboard', to: 'homepages#show'
  get '/trips-dashboard', to: 'homepages#show'

  match '*path', to: 'unknowns#index', via: :all
end
