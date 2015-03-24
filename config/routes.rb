Rails.application.routes.draw do
  resources :the_walls, only: [:show]

  root to: 'messages#new'

  resources :messages
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
end
