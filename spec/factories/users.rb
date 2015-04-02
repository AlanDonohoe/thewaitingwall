FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    sequence(:name) { |n| "foo#{n}" }
    password "please123"
    email { "#{name}@example.com" }
  end
end
