FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_with_profile do
      profile { association(:user_profile) }
    end
  end
end
