class Batch < ActiveRecord::Base
  has_many :messages
  has_many :background_images
  after_create :set_background_image
  after_create :collect_new_messages

  def background_image
    background_images.first || UnsetBackgroundImage.new
  end

  def image_url
    background_image.image_url
  end

  def set_background_image
    background_image = BackgroundImage.all.sample(1).first
    background_image.update_columns(batch_id: self.id)
  end

  def collect_new_messages
    puts 'Batch::collect_new_messages'
    total_no_of_letters = 0
    Message.approved_messages.limit(10).each do |message|
      total_no_of_letters += message.message_text.length
      break if total_no_of_letters > ENV['MAX_NO_OF_LETTERS_IN_BATCH'].to_i
      incremented_times_shown = message.times_shown + 1
      message.update_attributes(batch_id: self.id, times_shown: incremented_times_shown)
    end
    update_the_wall
  end

  def letter_count
    total_no_of_letters = 0
    messages.each {|message| total_no_of_letters +=  message.message_text.length }
    total_no_of_letters
  end

  def appended_messages
    appended_messages_text = ""
    messages.each do |message|
      appended_messages_text += message.message_text + "\n                    \n"
    end
    appended_messages_text
  end

  private

  def update_the_wall
    Pusher['the_waiting_wall'].trigger('wall_update', {}) unless Rails.env.test?
  end
end
