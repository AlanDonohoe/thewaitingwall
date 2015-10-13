require 'rails_helper'

RSpec.describe Batch, type: :model do

  describe '.collect_new_messages' do
    it 'should create a new batch of messages based on the total number of letters in the messages - short message text' do
      @ten_short_new_messages = create_list(:message, 10, approved: true, message_text: 'This is a message with 37 letters.')
      @batch_with_ten_short_messages = create(:batch)
      @batch_with_ten_short_messages.reload
      expect(@batch_with_ten_short_messages.letter_count).to be < ENV['MAX_NO_OF_LETTERS_IN_BATCH'].to_i
      first_message = @ten_short_new_messages.first
      first_message.reload
      expect(first_message.times_shown).to be 1
    end

    it 'should create a new batch of messages based on the total number of letters in the messages - long message text' do
      @ten_short_new_messages = create_list(:message, 10, approved: true, message_text: 'This is a message with 110 letters... This is a message with 110 letters. This is a message with 110 letters.')
      @batch_with_ten_short_messages = create(:batch)
      @batch_with_ten_short_messages.reload
      expect(@batch_with_ten_short_messages.letter_count).to be < ENV['MAX_NO_OF_LETTERS_IN_BATCH'].to_i
      first_message = @ten_short_new_messages.first
      first_message.reload
      expect(first_message.times_shown).to be 1
    end
  it 'should select messages in order of number of times they\'ve been shown before' do
      @never_shown_message = create(:message, approved: true, message_text: 'This is a brand new message')
      @shown_once_message = create(:message, approved: true, times_shown: 1, message_text: 'This is message has been shown once')
      @shown_twice_message = create(:message, approved: true, times_shown: 2, message_text: 'This is message has been shown twice')
      @new_batch = create(:batch)
      expect(@new_batch.messages[0]).to eq @never_shown_message
      expect(@new_batch.messages[1]).to eq @shown_once_message
      expect(@new_batch.messages[2]).to eq @shown_twice_message
    end
  end
end
