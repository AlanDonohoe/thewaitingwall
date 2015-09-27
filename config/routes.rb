Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  resources :walls, only: [:show]
  resources :messages do
    collection do
      put 'approve_or_delete'
    end
  end
  resources :background_images
  get   "/thewall" => "walls#show"
  get 'google76e2c5afc713d8b3.html' => 'static#google76e2c5afc713d8b3'
  get '/welcome' => 'high_voltage/pages#show', id: 'welcome'
end
