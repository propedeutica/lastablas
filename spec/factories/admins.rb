FactoryGirl.define do
  factory :admin do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }

    password "foobar123"
    password_confirmation "foobar123"
  end
end
