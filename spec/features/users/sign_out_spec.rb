feature 'Sign out', :devise do
  before do
    Tenant.create(name: '', subdomain: '') # default tenant...
  end
  scenario 'user signs out successfully' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link('Sign out', match: :first)
    # expect(page).to have_content I18n.t 'devise.sessions.signed_out'
    expect(page).to have_content('The Waiting Wall has been made possible by Brighton Digital Festival')
  end
end
