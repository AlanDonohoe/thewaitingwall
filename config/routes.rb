Rails.application.routes.draw do
  root to: 'messages#new'
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  resources :walls, only: [:show]
  resources :messages
  resources :background_images
  get   "/thewall" => "walls#show"
end
