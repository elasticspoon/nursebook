FactoryBot.define do
  factory :like do
    user
    association :target, factory: :post
  end
end
