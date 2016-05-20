#
# Offsprings are related to a user and only one user.
# They can have one shift assingned
#
class Offspring < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift
  validates :first_name, presence: true, length: { within: 3..60 }
  validates :last_name, presence: true, length: { within: 3..60 }
  validates :age, presence: true,
             numericality: { only_integer: true,
                             greater_than_or_equal_to: 10,
                             less_than_or_equal_to: 18 }
  validates :user, presence: true
  validates_each :shift do |offspring|
    if offspring.shift.nil?
      return
    else
      offspring.errors.add(:shift, "no hay espacio") if !offspring.shift.sites_available?
    end
  end

end


