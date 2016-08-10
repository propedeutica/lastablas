class Shift < ActiveRecord::Base
  REGEX = /\A([01]\d|2[0123]):[012345]\d\z/
  SCOPE = "activerecord.errors.models.shift".freeze # Necessary to acces locales file
  belongs_to :room
  has_many :offsprings, dependent: :nullify
  validates :day_of_week, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1,
    less_than_or_equal_to: 7 }
  validates :start_time, presence: true
  validates :start_time, format: { with: REGEX, message: I18n.t("wrong_regex", scope: SCOPE) }
  validates :end_time, presence: true
  validates :end_time, format: { with: REGEX, message: I18n.t("wrong_regex", scope: SCOPE) }
  validates_each :end_time do |shift|
    shift.errors.add(:shift, I18n.t("bad_time_continuity", scope: SCOPE)) if shift.start_time > shift.end_time
  end
  validates :prebooked, numericality: { only_integer: true }
  validates_each :prebooked do |shift|
    shift.errors.add(:shift, I18n.t("sites_available_under_0", scope: SCOPE)) if shift.sites_available < 0
  end

  def sites_available?
    room.capacity - prebooked - offsprings.count > 0
  end

  def sites_available
    room.capacity - prebooked - offsprings.count
  end
end
