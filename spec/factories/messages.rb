FactoryGirl.define do
  factory :message do
    approved false
    times_shown 0
    message_text 'This is a message'
  end

end
