FactoryBot.define do
  factory :post do
    association :creator, factory: :user
    content { Faker::Lorem.paragraph }
  end
end
