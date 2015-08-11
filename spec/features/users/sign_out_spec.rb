feature 'Sign out', :devise do
  scenario 'user signs out successfully' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link('Sign out', match: :first)
    # expect(page).to have_content I18n.t 'devise.sessions.signed_out'
    # no messages in main wall - and now root is the wall
    expect(page).to have_content('write message')
  end
end
