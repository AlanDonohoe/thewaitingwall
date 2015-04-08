class Message < ActiveRecord::Base
  default_scope { order('times_shown DESC') }
  scope :approved_messages, -> {where('approved = true')}
  scope :unapproved_messages, -> {where('approved = false')}
  # def self.least_shown_approved_messages
  #   Message.where('approved = true').order('times_shown DESC')
  # end

end
