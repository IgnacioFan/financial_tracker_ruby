FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:password) { |n| "123456" }
  end
end
