Rails.application.routes.draw do

  resources :stations
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  root "homepages#index"
  resources :users, only: [:new, :create, :index, :show]

  resources :stations, shallow: true do
    resources :trips, only: [:show]
  end

end
