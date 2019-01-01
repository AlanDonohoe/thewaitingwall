require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thewaitingwall
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.to_prepare do
      Devise::SessionsController.layout "devise_layout"
      Devise::RegistrationsController.layout "devise_layout" 
      Devise::ConfirmationsController.layout "devise_layout"
      Devise::UnlocksController.layout "devise_layout"            
      Devise::PasswordsController.layout "devise_layout"        
    end
  end
end
