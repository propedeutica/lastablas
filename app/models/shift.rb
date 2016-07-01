class Shift < ActiveRecord::Base
  belongs_to :room
  has_many :offsprings, dependent: :nullify
  validates :day_of_week, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to:1, less_than_or_equal_to:7 }
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :prebooked, :presence => true, numericality: { only_integer:true }
  validates_each :prebooked do |shift,room|
      shift.errors.add(:shift, "no puede ser mayor que la capacidad de la sala") unless shift.sites_available?
  end
  validate :sites_available_gt_0
  validate :regexed_time
  validate :time_continuity
  before_save :always_same_week

  def sites_available?
    return self.room.capacity- self.prebooked-self.offsprings.count > 0
  end

  def sites_available
    return self.room.capacity- self.prebooked-self.offsprings.count
  end

  private
    #Custom validation to ensure sites_available greater than prebooked
    def sites_available_gt_0
      if sites_available?
        return true
      else
        errors.add(:prebooked, 'More prebooked than sites_available')
        return false
      end
    end

    def regexed_time
      regex = /^\d{0,4}-(0[123456789]|1[012])-(0[123456789]|[12]\d|3[01])\s([01]\d|2[0123]):[012345]\d:[012345]\d$/
      if (start_time !~ regex)
        errors.add(:start_time, 'Wrong start time')
        return false
      end

      if (end_time !~ regex)
        errors.add(:end_time, 'Wrong end time')
        return false
      end
      return true

    end

    def time_continuity
      if (start_time < end_time)
        return true
      else
        errors.add(:end_time, 'End time is ahead of start time')
        return false
      end 
    end

    def always_same_week
      day=self.day_of_week
      #day=1 unless (1..7).include?(day)
      self.start_time ||= "00:00"
      self.end_time ||= "01:00"
    end
end
