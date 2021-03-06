# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  before do
    Tenant.create(name: '', subdomain: '') # default tenant...
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  scenario 'visit the home page' do
    visit new_message_path
    expect(page).to have_content 'The Waiting Wall'
    expect(page).to have_content 'The What? The Who?'
  end

end
