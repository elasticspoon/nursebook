FactoryBot.define do
  factory :liked_comment do
    association :target, factory: :comment
    user
  end
end
