FactoryGirl.define do
  factory :message do
    message_text "My Message"
    approved false
    times_shown 0
  end

end
