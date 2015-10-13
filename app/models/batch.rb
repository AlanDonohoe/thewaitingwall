class Batch < ActiveRecord::Base
  has_many :messages
  has_many :background_images
  before_create :reset_messages_times_shown_if_stale
  after_create :set_background_image
  after_create :collect_new_messages
  after_create :destroy_previous_batch

  # If there's no recently approved messages (none with times shown = 0), then refresh a bunch of
  # old messages - so we dont just get the same last approved messages being shown
  def reset_messages_times_shown_if_stale
    puts 'reset_messages_times_shown_if_stale'
    return if Message.approved_messages.first.nil? || Message.approved_messages.first.times_shown == 0
    Message.approved_messages.limit(50).order("RANDOM()").each do |message|
      message.update_attributes(times_shown: 1)
      puts 'Reseting message times shown: ' + message.message_text.inspect + ' - Times show: ' + message.times_shown.inspect
    end
  end

  def background_image
    background_images.first || UnsetBackgroundImage.new
  end

  def image_url
    background_image.image_url
  end

  def set_background_image
    background_image = BackgroundImage.all.sample(1).first
    background_image.update_columns(batch_id: self.id) unless background_image.nil?
  end

  def collect_new_messages
    puts 'Batch::collect_new_messages'
    total_no_of_letters = 0
    Message.approved_messages.limit(44).each do |message|
      total_no_of_letters += message.message_text.length
      break if total_no_of_letters > ENV['MAX_NO_OF_LETTERS_IN_BATCH'].to_i
      incremented_times_shown = message.times_shown + 1
      message.update_attributes(batch_id: self.id, times_shown: incremented_times_shown)
    end
    update_the_wall
  end

  def destroy_previous_batch
    return unless Batch.count > 2
    Batch.first.destroy
  end

  def letter_count
    total_no_of_letters = 0
    messages.each {|message| total_no_of_letters +=  message.message_text.length }
    total_no_of_letters
  end

  def appended_messages(add_promo_text = false)
    appended_messages_text = ""
    count = 0
    shuffled_messages = messages.shuffle 
    shuffled_messages.each do |message|
      count += 1
      appended_messages_text += message.message_text + "\n                    \n"
      appended_messages_text += "the waiting wall.com - Inspired by Alain de Botton's Secular Version of Jerusalem's Wailing Wall - Visit the waiting wall.com to leave a message - #BDF15" + "\n                    \n" if ( add_promo_text && 0 == count % 3)
    end
    appended_messages_text
  end

  private

  def update_the_wall
    Pusher['the_waiting_wall'].trigger('wall_update', {}) unless Rails.env.test?
  end
end
