require 'rails_helper'

feature 'User posts a message to the wall' do
  scenario 'they enter some message and submit the new message and visit the wall before it is approved' do
    @wall = create(:wall)
    visit new_message_path
    fill_in 'message_message_text', with: 'this is my message for the wall'
    click_on 'Post to the wall'
    expect(page).to have_content('Thank you')
    # expect(page).to have_content('this is my message for the wall')
    visit wall_path(@wall)
    expect(page).to_not have_content('this is my message for the wall')
  end

  scenario 'a user views an approved message on the wall' do
    pending "message does display but in flapper"
    @wall = create(:wall)
    @approved_message = create(:message, approved: true, message_text: 'this is an approved message')
    visit wall_path(@wall)
    #  now message is in hidden div and flapper display
    # find('div#current_batch_of_messages').should have_content(@approved_message.message_text)
    # within('#current_batch_of_messages') do
    #   expect(page).to have_content(@approved_message.message_text.upcase)
    # end
    expect(page).to have_content(@approved_message.message_text)
  end

  scenario 'they post a message thats too long for the wall' do
    # pending
    #  do we need to set a max no of letters per message??
  end
end