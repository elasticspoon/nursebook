FactoryBot.define do
  factory :request do
    accepted { false }
    sender { nil }
    receiver { nil }
  end
end
