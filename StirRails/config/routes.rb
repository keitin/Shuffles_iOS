Rails.application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :groups
  get "secret" => "home#secret", :as => "secret"
  root :to => "home#index"

  #api
  namespace :api, default: {format: :json} do
    resources :users, only: [:index, :create]
    resources :sessions, only: [:create]
    resources :groups, only: [:index, :create]
    resources :tweets, only: [:index, :create]
    get     '/groups/search'            => 'groups#search'
    get     '/groups/add_group'         => 'groups#add_group'
    get     '/groups/fake_users'        => 'groups#fetch_fake_users'
    put     '/users/update'             => 'users#update'
    get     '/users/fetch_current_user' => 'users#fetch_user'
    get     '/users/group/curret_user'  => 'users#fetch_current_fake_user_in_group'
    put     '/fakes/checked'            => 'fakes#checked'
  end
end
