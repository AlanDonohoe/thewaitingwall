require 'rails_helper'

feature 'User views the wall' do
  scenario 'user views different types of background behind the wall' do
    @wall = create(:wall)
    # default colour with no other params:
    visit wall_path(@wall)
    find(:css, 'body')['style'].should == 'background-color:black'
    # coloured background:
    visit wall_path(@wall, {background: 'blue'})
    find(:css, 'body')['style'].should == 'background-color:blue'
    # image background
    # TODO 
  end
end
