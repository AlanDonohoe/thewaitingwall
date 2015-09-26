require 'rails_helper'

feature 'Admin user tries to access various parts of the app and edit messages' do
  before :each do
    @wall = create(:wall)
    @admin_user = create(:user, email: 'admin@example.com')
    @five_unapproved_messages = create_list(:message, 5)
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
    approved_message = create(:message, approved: true, message_text: 'Approved Message')
    visit edit_message_path(approved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(approved_message.message_text)
  end

  scenario 'visit unapproved message edit page' do
    visit edit_message_path(@five_unapproved_messages[0])
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
  end

  scenario 'visit approved show message page' do
    approved_message = create(:message, approved: true, message_text: 'Approved Message')
    visit message_path(approved_message)
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(approved_message.message_text)
  end

  scenario 'visit unapproved show message page' do
    visit message_path(@five_unapproved_messages[0])
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
  end

  scenario 'visit view all messages page' do
    approved_message = create(:message, approved: true, message_text: 'Approved Message')
    visit messages_path
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
    expect(page).to_not have_content(approved_message.message_text)
  end

  scenario 'visit the wall page' do
    pending "message does display but in flapper"
    visit wall_path(@wall)
    expect(page).to have_content('Approved Message')
    expect(page).to_not have_content('You need to sign in or sign up before continuing')
  end
  
  scenario 'they approve a message' do
    visit messages_path
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
    expect(page).to have_content(@five_unapproved_messages[1].message_text)
    expect(page).to have_content(@five_unapproved_messages[2].message_text)
    expect(page).to have_content(@five_unapproved_messages[3].message_text)
    expect(page).to have_content(@five_unapproved_messages[4].message_text)
    find(:css, "#approve_message_#{@five_unapproved_messages[0].id}").set(true)
    find(:css, "#approve_message_#{@five_unapproved_messages[1].id}").set(true)
    find(:css, "#approve_message_#{@five_unapproved_messages[2].id}").set(true)
    click_on('Approve/Delete')
    expect(page).to_not have_content(@five_unapproved_messages[0].message_text)
    expect(page).to_not have_content(@five_unapproved_messages[1].message_text)
    expect(page).to_not have_content(@five_unapproved_messages[2].message_text)
    expect(page).to have_content(@five_unapproved_messages[3].message_text)
    expect(page).to have_content(@five_unapproved_messages[4].message_text)
    expect(Message.count).to eq 5 # just check that we're not deleting messages
  end

  scenario 'they delete a message' do
    visit messages_path
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
    expect(page).to have_content(@five_unapproved_messages[1].message_text)
    expect(page).to have_content(@five_unapproved_messages[2].message_text)
    expect(page).to have_content(@five_unapproved_messages[3].message_text)
    expect(page).to have_content(@five_unapproved_messages[4].message_text)
    find(:css, "#delete_message_#{@five_unapproved_messages[2].id}").set(true)
    find(:css, "#delete_message_#{@five_unapproved_messages[3].id}").set(true)
    find(:css, "#delete_message_#{@five_unapproved_messages[4].id}").set(true)
    click_on('Approve/Delete')
    expect(page).to have_content(@five_unapproved_messages[0].message_text)
    expect(page).to have_content(@five_unapproved_messages[1].message_text)
    expect(page).to_not have_content(@five_unapproved_messages[2].message_text)
    expect(page).to_not have_content(@five_unapproved_messages[3].message_text)
    expect(page).to_not have_content(@five_unapproved_messages[4].message_text)
    expect(Message.count).to eq 2
  end

  scenario 'they delete a message and then reinstate' do
    # pending("bring in soft delete... paranoid gem")
  end
 end