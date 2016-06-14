class Shift < ActiveRecord::Base
  belongs_to :room
  has_many :offsprings, dependent: :nullify
  validates :day_of_week, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :prebooked, :presence => true, numericality: { only_integer:true }
  before_validation :always_same_week

  def sites_available?
    return self.room.capacity- self.prebooked-self.offsprings.count > 0
  end

  def sites_available
    return self.room.capacity- self.prebooked-self.offsprings.count
  end

  private

    def always_same_week
      self.day_of_week ||= 8 # Esto no tiene sentido
      self.start_time ||= "00:00"
      self.end_time ||= "01:00"
      self.start_time=DateTime.new(year=2001, month=1, day=self.day_of_week, hour=self.start_time.hour, min=self.start_time.min)
      self.end_time=DateTime.new(year=2001,month=1,day=self.day_of_week,hour=self.end_time.hour, min=self.end_time.min)
    end


end
