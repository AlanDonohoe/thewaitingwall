require 'rails_helper'

feature 'Admin user tries to access various parts of the app and edit messages' do
  before :each do
    @wall = create(:wall)
    @admin_user = create(:user, email: 'admin@example.com')
    @approved_message = create(:message, approved: true, message_text: 'Approved Message')
    @unapproved_message = create(:message, message_text: 'Unapproved Message')
    @admin_user.update_columns(role: 'admin')
    signin(@admin_user.email, @admin_user.password)
  end

  scenario 'visit new message page' do
    visit new_message_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post to the wall'
    expect(page).to have_content('Message was successfully created.')
  end

  scenario 'visit approved message edit page' do
    visit edit_message_path(@approved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@approved_message.message_text)
  end

  scenario 'visit unapproved message edit page' do
    visit edit_message_path(@unapproved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@unapproved_message.message_text)
  end

  scenario 'visit approved show message page' do
    visit message_path(@approved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@approved_message.message_text)
  end

  scenario 'visit unapproved show message page' do
    visit message_path(@unapproved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@unapproved_message.message_text)
  end

  scenario 'visit view all messages page' do
    visit messages_path
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@unapproved_message.message_text)
    expect(page).to_not have_content(@approved_message.message_text)
  end

  scenario 'visit the wall page' do
    pending "message does display but in flapper"
    visit wall_path(@wall)
    expect(page).to have_content('Approved Message')
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
  end
  
  scenario 'they approve a message' do
    visit edit_message_path(@unapproved_message)
    check 'message_approved'
    click_on('Update message')
    # expect(page).to have_content('Message was successfully updated.')
    @unapproved_message.reload
    expect(@unapproved_message.approved).to eq true
    expect(@unapproved_message.user_id).to eq @admin_user.id
    visit messages_path
    expect(page).to_not have_content('Approved Message')
  end

  scenario 'they delete a message and then reinstate' do
    # pending("bring in soft delete... paranoid gem")
  end
 end