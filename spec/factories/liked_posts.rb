FactoryBot.define do
  factory :liked_post do
    association :target, factory: :post
    user
  end
end
