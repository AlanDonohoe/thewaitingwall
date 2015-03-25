FactoryGirl.define do
  factory :message do
    message_text "MyText"
    approved false
    times_shown 0
  end

end
