class Shift < ActiveRecord::Base
  REGEX = /^([01]\d|2[0123]):[012345]\d$/
  SCOPE = "activerecord.errors.models.shift".freeze
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
    errors.add(:shift, I18n.t("sites_available_under_0", scope: SCOPE))
    false
  end

  def regexed_time
    if start_time !~ REGEX
      errors.add(:start_time, I18n.t("wrong_regex", scope: SCOPE))
      return false
    end

    if end_time !~ REGEX
      errors.add(:end_time, I18n.t("wrong_regex", scope: SCOPE))
      return false
    end
    true
  end

  def time_continuity
    return true if start_time < end_time
    errors.add(:shift, I18n.t("bad_time_continuity", scope: SCOPE))
    false
  end
end
