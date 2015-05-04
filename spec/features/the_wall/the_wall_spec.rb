require 'rails_helper'

feature 'User views the wall' do
  before do
    @wall = create(:wall)
  end
  scenario 'user views different types of background behind the wall' do
    # default colour with no other params:
    visit wall_path(@wall)
    find(:css, 'body')['style'].should == 'background-color:black'
    # coloured background:
    visit wall_path(@wall, {background: 'blue'})
    find(:css, 'body')['style'].should == 'background-color:blue'
  end

  scenario 'admin uploads background image' do
    @admin_user = create(:user, email: 'admin@example.com', role: 'admin')
    signin(@admin_user.email, @admin_user.password)
    visit new_background_image_path
    attach_file('background_image_image', File.expand_path('spec/assets/background_1.jpg'))
    click_on('Upload image')
    expect(page).to have_content('Image was successfully created.')
  end
end


