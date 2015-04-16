require 'rails_helper'

RSpec.describe Batch, type: :model do

  describe '.collect_new_messages' do
    it 'should create a new batch of messages based on the total number of letters in the messages - short message text' do
      @ten_short_new_messages = create_list(:message, 10, approved: true, message_text: 'This is a message with 37 letters.')
      @batch_with_ten_short_messages = create(:batch)
      @batch_with_ten_short_messages.reload
      expect(@batch_with_ten_short_messages.messages.count).to eq(5)
      expect(@batch_with_ten_short_messages.letter_count).to be < Batch::MAX_NO_OF_LETTERS_IN_BATCH
      first_message = @ten_short_new_messages.first
      last_message = @ten_short_new_messages.last
      first_message.reload
      last_message.reload
      expect(first_message.times_shown).to be 1
      expect(last_message.times_shown).to be 0
    end

    it 'should create a new batch of messages based on the total number of letters in the messages - long message text' do
      @ten_short_new_messages = create_list(:message, 10, approved: true, message_text: 'This is a message with 110 letters... This is a message with 110 letters. This is a message with 110 letters.')
      @batch_with_ten_short_messages = create(:batch)
      @batch_with_ten_short_messages.reload
      expect(@batch_with_ten_short_messages.messages.count).to eq(1)
      expect(@batch_with_ten_short_messages.letter_count).to be < Batch::MAX_NO_OF_LETTERS_IN_BATCH
      first_message = @ten_short_new_messages.first
      last_message = @ten_short_new_messages.last
      first_message.reload
      last_message.reload
      expect(first_message.times_shown).to be 1
      expect(last_message.times_shown).to be 0
    end
  end
end
