FactoryBot.define do
  factory :notification do
    content { Faker::Lorem.sentence }
    association :target, factory: :user
    association :source, factory: :comment
  end
end
