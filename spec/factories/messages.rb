FactoryGirl.define do
  factory :message do
    # association :tenant
    approved false
    times_shown 0
    sequence(:message_text) { |n| "Message #{n}" }
    trait :approved do
      approved true
    end
  end

end
