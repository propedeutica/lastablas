FactoryGirl.define do
  factory :room do
    name { Faker::Name.name }
    capacity { Faker::Number.between(20, 35) }
  end
end
