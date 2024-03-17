FactoryBot.define do
  factory :product do
    association :user

    sequence(:name) { |n| "product #{n}" }
    sequence(:description) { |n| "product #{n} description" }
    sequence(:price) { 10 }
  end
end
