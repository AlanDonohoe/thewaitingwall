Rails.application.routes.draw do
  root to: 'messages#new'
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  resources :walls, only: [:show]
  resources :messages
  get   "/thewall" => "walls#show"
  # get "users/sign_up" => "users/sign_in"
end
