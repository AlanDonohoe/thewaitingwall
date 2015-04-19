class Batch < ActiveRecord::Base
  MAX_NO_OF_LETTERS_IN_BATCH = 200
  has_many :messages
  after_create :collect_new_messages

  def collect_new_messages
    total_no_of_letters = 0
    Message.approved_messages.limit(10).each do |message|
      total_no_of_letters += message.message_text.length
      break if total_no_of_letters > MAX_NO_OF_LETTERS_IN_BATCH
      incremented_times_shown = message.times_shown + 1
      message.update_attributes(batch_id: self.id, times_shown: incremented_times_shown)
    end
  end

  def letter_count
    total_no_of_letters = 0
    messages.each {|message| total_no_of_letters +=  message.message_text.length }
    total_no_of_letters
  end

  def appended_messages
    appended_messages_text = ""
    messages.each do |message|
      appended_messages_text += message.message_text + "\n....................\n"
    end
    appended_messages_text
  end
end
