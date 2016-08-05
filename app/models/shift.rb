class Shift < ActiveRecord::Base
  belongs_to :room
  has_many :offsprings, dependent: :nullify
  validates :day_of_week,
            presence:     true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :prebooked, presence: true, numericality: { only_integer: true }
  validates_each :prebooked do |shift, _room|
    shift.errors.add(:shift, "no puede ser mayor que la capacidad de la sala") unless shift.sites_available?
  end

  def sites_available?
    room.capacity - prebooked - offsprings.count > 0
  end

  def sites_available
    room.capacity - prebooked - offsprings.count
  end
end
