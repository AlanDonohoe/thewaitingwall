require 'rails_helper'

feature 'Boss user tries to access various parts of the app and edit messages' do
  before :all do
    @wall = create(:wall)
  end
  scenario 'visit new message page' do
    
    # visit root_path
  end

  scenario 'visit edit message page' do
    # @wall = create(:wall)
    # visit root_path
  end

  scenario 'visit show message page' do
    # @wall = create(:wall)
    # visit root_path
  end

  scenario 'visit view all messages page' do
    # @wall = create(:wall)
    # visit root_path
  end

  scenario 'visit the wall page' do
    # @wall = create(:wall)
    # visit root_path
  end

  scenario 'visit sign up page' do
    # @wall = create(:wall)
    # visit root_path
  end
 end