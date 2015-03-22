Rails.application.routes.draw do
  root to: 'messages#new'

  resources :messages
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
end
