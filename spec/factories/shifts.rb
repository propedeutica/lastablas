FactoryGirl.define do
  factory :shift do
    day_of_week 1
    start_time "2001-01-01 10:00:00"
    end_time "2001-01-01 10:45:00"
    prebooked 5
    association :room
  end
end
