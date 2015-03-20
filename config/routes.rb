Rails.application.routes.draw do
  resources :messages

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
