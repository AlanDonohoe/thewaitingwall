# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise do

  # Scenario: View navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "home," "sign in," and "sign up"
  scenario 'admin user views devise navigation links, but not the ability to sign up' do
    visit new_user_session_path
    expect(page).to have_content 'Sign in'
    expect(page).to_not have_content 'Sign up'
    expect(page).to_not have_content 'The What?'
    expect(page).to_not have_content 'The Why?'
  end

  scenario 'regular user does not see devise navigation links' do
    visit root_path
    expect(page).to_not have_content 'Sign in'
    expect(page).to_not have_content 'Sign up'
    expect(page).to have_content 'The What?'
    expect(page).to have_content 'The Why?'
  end

  scenario 'visiting the wall user does not see navigation links' do
    visit messages_path
    expect(page).to_not have_content 'Sign in'
    expect(page).to_not have_content 'Sign up'
    expect(page).to_not have_content 'The What?'
    expect(page).to_not have_content 'The Why?'
  end

end
