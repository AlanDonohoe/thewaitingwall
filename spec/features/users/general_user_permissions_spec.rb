require 'rails_helper'

feature 'General user tries to access various parts of the app' do
  before :all do
    @wall = create(:wall)
  end
  scenario 'visit new message page' do
    visit root_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post my message to the wall'
    expect(page).to have_content('Message was successfully created.')
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