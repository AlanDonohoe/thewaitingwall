class Message < ActiveRecord::Base
  def self.least_shown_approved_messages
    Message.where('approved = true').order('times_shown DESC')
  end
end
