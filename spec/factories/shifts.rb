FactoryGirl.define do
  factory :shift do
    day_of_week 1
    start_time "10:00"
    end_time "10:45"
    prebooked 5
    association :room
  end
end
