require 'rails_helper'

feature 'User posts a message to the wall' do
  before do
    Tenant.create(name: '', subdomain: '') # default tenant...
    @wall = create(:wall)
  end
  scenario 'they enter some message and submit the new message and visit the wall before it is approved' do
    visit new_message_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post to the wall'
    expect(page).to have_content('Thank you')
    Tenant.all.each { |tenant| tenant.create_batch } # run the batch method
    visit wall_path(@wall)
    within('#current_batch_of_messages') do
      expect(page).to_not have_content('this is my message for the wall')
    end
  end
  scenario 'a user views an approved message on the wall' do
    visit new_message_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post to the wall'
    msg = Message.find_by_message_text('this is my message for the wall')
    msg.update_columns(approved: true)
    Tenant.all.each { |tenant| tenant.create_batch } # run the batch method
    visit wall_path(@wall)
    within('#current_batch_of_messages') do
      expect(page).to have_content msg.message_text
    end
  end
end