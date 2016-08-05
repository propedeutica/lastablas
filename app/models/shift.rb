class Shift < ActiveRecord::Base
  belongs_to :room
  has_many :offsprings, dependent: :nullify
  validates :day_of_week, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1,
    less_than_or_equal_to: 7 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :prebooked, presence: true, numericality: { only_integer: true }
  validates_each :prebooked do |shift|
    shift.errors.add(:shift, "no puede ser mayor que la capacidad de la sala") if shift.nil? && !shift.sites_available?
  end
  validate :sites_available_gt_0
  validate :regexed_time
  validate :time_continuity

  def sites_available?
    room.capacity - prebooked - offsprings.count > 0
  end

  def sites_available
    room.capacity - prebooked - offsprings.count
  end

  private

  def sites_available_gt_0
    return true if sites_available? && sites_available >= 0
    errors.add(:shift, 'Sites available under 0')
    false
  end

  def regexed_time
    regex = /([01]\d|2[0123]):[012345]\d$/
    if start_time !~ regex
      errors.add(:start_time, 'Wrong start time')
      return false
    end

    if end_time !~ regex
      errors.add(:end_time, 'Wrong end time')
      return false
    end
    true
  end

  def time_continuity
    return true if start_time < end_time
    errors.add(:end_time, 'End time is ahead of start time')
    false
  end
end
