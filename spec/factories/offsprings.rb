FactoryGirl.define do
  factory :offspring do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    grade { 0 }
    association :user
  end
end
