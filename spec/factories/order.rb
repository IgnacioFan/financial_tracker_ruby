FactoryBot.define do
  factory :order do
    creator { association :user }

    sequence(:status) { "pending" }
  end
end
