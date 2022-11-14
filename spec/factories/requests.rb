FactoryBot.define do
  factory :request do
    accepted { false }
    association :sender, factory: :user
    association :receiver, factory: :user
  end
end
