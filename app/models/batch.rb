class Batch < ActiveRecord::Base
  has_many :messages
  has_many :background_images
  after_create :set_background_image
  after_create :collect_new_messages
  after_create :destroy_previous_batch

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
    messages.each_with_index do |message, count|
      count_plus_one = count + 1
      appended_messages_text += message.message_text + "\n                    \n"
      appended_messages_text += 'the waiting wall.com' + "\n                    \n" if ( add_promo_text && 0 == count_plus_one % 3)
    end
    appended_messages_text
  end

  private

  def update_the_wall
    Pusher['the_waiting_wall'].trigger('wall_update', {}) unless Rails.env.test?
  end
end
