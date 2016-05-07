FactoryGirl.define do
  factory :offspring do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { Faker::Number.between(12, 16) }
    association :user
  end
end
