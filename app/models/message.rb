class Message < ActiveRecord::Base
  default_scope { order('times_shown DESC') }
  scope :approved_messages, -> {where('approved = true')}
  scope :unapproved_messages, -> {where('approved = false')}
end
