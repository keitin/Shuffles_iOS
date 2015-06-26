Rails.application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  get "secret" => "home#secret", :as => "secret"
  root :to => "home#index"

  #api
  namespace :api, default: {format: :json} do
    resources :users, only: [:index, :create]
    resources :sessions, only: [:create]
    resources :groups, only: [:index, :create]
    resources :tweets, only: [:index]
    get '/groups/search' => 'groups#search'
    get '/groups/add_group' => 'groups#add_group'
  end
end
