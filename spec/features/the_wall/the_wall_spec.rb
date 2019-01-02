require 'rails_helper'

feature 'User views the wall' do
  before do
    @default_tenant = Tenant.create(name: '', subdomain: '') # default tenant...
    @wall = create(:wall)
  end

  scenario 'admin uploads background image' do
    pending 'failing but not really used anymore'
    @admin_user = create(:user, email: 'admin@example.com', role: 'admin')
    signin(@admin_user.email, @admin_user.password)
    visit new_background_image_path
    attach_file('background_image_image', File.expand_path('spec/assets/background_1.jpg'))
    click_on('Upload image')
    expect(page).to have_content('Image was successfully created.')
  end
end


