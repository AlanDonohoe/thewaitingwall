require 'rails_helper'

feature 'User views the wall' do
  scenario 'user views different types of background behind the wall' do
    @wall = create(:wall)
    visit wall_path(@wall)
    # body = page.find(:css, 'body')
    find(:css, 'body')['style'].should == 'background-color:'
    # coloured background:
    visit wall_path(@wall, {background: 'black'})
    find(:css, 'body')['style'].should == 'background-color:black'
  end
end
