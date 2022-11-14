FactoryBot.define do
  factory :user_profile do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    location { Faker::Address.city }
  end
end
