FactoryGirl.define do
  factory :message do
    approved false
    times_shown 0
    sequence(:message_text) { |n| "Message #{n}" }
  end

end
