class Shift < ActiveRecord::Base
  belongs_to :room
  validates :day_of_week, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :prebooked, :presence => true, numericality: { only_integer:true }
end
