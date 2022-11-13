FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :creator, factory: :user
    post
    association :parent, factory: :post
  end
end
