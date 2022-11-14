FactoryBot.define do
  factory :friendship do
    user_one { nil }
    user_two { nil }
    friends_count { 1 }
  end
end
