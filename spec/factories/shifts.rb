FactoryGirl.define do
  factory :shift do
    day_of_week 1
    start_time "2016-04-28 09:16:00"
    end_time "2016-04-28 10:16:00"
    prebooked 5
    association :room
  end
end
