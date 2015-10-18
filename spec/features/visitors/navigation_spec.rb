feature 'Navigation links', :devise do

  before do
    Tenant.create(name: '', subdomain: '') # default tenant...
  end

  scenario 'admin user views devise navigation links, but not the ability to sign up' do
    visit new_user_session_path
    expect(page).to have_content 'Sign in'
    expect(page).to_not have_content 'Sign up'
    expect(page).to_not have_content 'The What?'
  end

  scenario 'regular user does not see devise navigation links' do
    visit new_message_path
    expect(page).to_not have_content 'Sign in'
    expect(page).to_not have_content 'Sign up'
    expect(page).to have_content 'The What?'
  end

  scenario 'visiting the wall user does not see navigation links' do
    visit messages_path
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
