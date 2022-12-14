FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :creator, factory: :user
    association :parent, factory: :post
  end
end
