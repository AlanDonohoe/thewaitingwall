require 'rails_helper'

feature 'General user tries to access various parts of the app' do
  before :all do
    @wall = create(:wall)
    @approved_message = create(:message, approved: true)
  end
  scenario 'user visits new message page' do
    visit root_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post my message to the wall'
    expect(page).to have_content('Message was successfully created.')
  end

  scenario 'user visits edit message page' do
    visit edit_message_path(@approved_message)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  scenario 'user visits show message page' do
    visit message_path(@approved_message)
    expect(page).to have_content('My Message')
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
  end

  scenario 'user visits view all messages page' do
    visit messages_path
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  scenario 'user visits the wall page' do
    visit wall_path(@wall)
    expect(page).to have_content('My Message')
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
  end

  scenario 'user visits sign up page, signs up and then tries to visit admin only areas' do
    ActionMailer::Base.deliveries = []
    visit new_user_registration_path
    fill_in 'user_email', with: 'theguys@freethetrees.co.uk'
    fill_in 'user_password', with: 'password123'
    fill_in 'user_password_confirmation', with: 'password123'
    click_on 'Sign up'
    last_email = ActionMailer::Base.deliveries.last
    ctoken = last_email.body.match(/confirmation_token=\w*/)
    visit "/users/confirmation?#{ctoken}"
    # save_and_open_page
    fill_in 'user_email', with: 'theguys@freethetrees.co.uk'
    fill_in 'user_password', with: 'password123'
    click_on 'Log in'
    # as user has not been classified as an admin yet:
    expect(page).to_not have_content('Approve messages')
    
    visit messages_path
    expect(page).to have_content('You are not authorized to access this page')
    expect(page).to_not have_content('My Message')

    visit edit_message_path(@approved_message)
    expect(page).to have_content('You are not authorized to access this page')
    expect(page).to_not have_content('My Message')
  end
end
