def switch_to_subdomain(subdomain)
    # lvh.me always resolves to 127.0.0.1
    Capybara.app_host = "http://#{subdomain}.lvh.me"
end

def switch_to_main_domain
  # Capybara.app_host = "http://lvh.me"
end