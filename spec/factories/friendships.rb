FactoryBot.define do
  factory :friendship do
    association :user_one, factory: :user
    association :user_two, factory: :user
  end
end
