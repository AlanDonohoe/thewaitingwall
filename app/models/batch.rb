class Batch < ActiveRecord::Base
  has_many :messages
  has_many :background_images
  belongs_to :tenant
  before_create :reset_messages_times_shown_if_stale
  after_create :set_background_image
  after_create :collect_new_messages
  after_create :destroy_previous_batch

  PAGE_BREAK = "\n                    \n"

  def assign_default_tenant_if_unowned
    return if tenant.present?
    update_columns(tenant_id: Tenant.default_tenant.id)
  end

  def tenant_approved_messages(limit = 100)
    tenant.messages.approved_messages.limit(limit)
  end

  def tenant_approved_messages_first
    tenant_approved_messages.first
  end

  def message
    messages.first
  end

  def background_image
    background_images.first || UnsetBackgroundImage.new
  end

  def image_url
    background_image.image_url
  end

  def appended_messages(add_promo_text = false)
    appended_messages_text = ""
    messages.shuffle.each_with_index do |message|
      appended_messages_text += message.message_text + PAGE_BREAK if message.message_text.present?
      appended_messages_text += tenant.info_text + PAGE_BREAK if ( add_promo_text && tenant.info_text.present? && 0 == (count + 1) % 3)
    end
    appended_messages_text
  end

  def letter_count
    total_no_of_letters = 0
    messages.each {|message| total_no_of_letters +=  message.message_text.length }
    total_no_of_letters
  end

  private

  # new multi tenant version:
  def reset_messages_times_shown_if_stale
    return if tenant.nil? || tenant_approved_messages_first.nil? || tenant_approved_messages_first.times_shown == 0
    tenant_approved_messages(50).order("RANDOM()").each do |message|
      message.times_shown = 1
      message.tenant_id = default_tenant.id if message.tenant.nil?
      message.save
      puts 'Reseting message times shown: ' + message.message_text.inspect + ' - Times show: ' + message.times_shown.inspect
    end
  end

  def collect_new_messages
    puts 'Batch::collect_new_messages'
    assign_default_tenant_if_unowned
    total_no_of_letters = 0
    tenant_approved_messages(44).each do |message|
      total_no_of_letters += message.message_text.length
      break if total_no_of_letters > ENV['MAX_NO_OF_LETTERS_IN_BATCH'].to_i
      incremented_times_shown = message.times_shown + 1
      message.update_attributes(batch_id: self.id, times_shown: incremented_times_shown)
    end
    # TODO: remove this pusher call and just user a JS 10 min timer: then turn off pusher...
    #  http://stackoverflow.com/questions/4114268/how-to-make-ajax-requests-each-10-seconds-besides-long-polling
    update_the_wall
  end

  def update_the_wall
    Pusher['the_waiting_wall'].trigger('wall_update', {}) unless Rails.env.test?
  end

  def set_background_image
    background_image = BackgroundImage.all.sample(1).first
    background_image.update_columns(batch_id: self.id) unless background_image.nil?
  end

  def destroy_previous_batch
    return if tenant.nil?
    tenant.oldest_batch.destroy if tenant.batch_count > 2
  end
end
