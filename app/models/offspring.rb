#
# Offsprings are related to a user and only one user.
# They can have one shift assingned
#
class Offspring < ActiveRecord::Base
  enum grade: %i(primary_first primary_second primary_third others)
  belongs_to :user
  belongs_to :shift
  validates :first_name, presence: true, length: { within: 3..60 }
  validates :last_name, presence: true, length: { within: 3..60 }
  validates :grade, presence: true
  validates :user, presence: true
  validates_each :shift do |offspring|
    if !offspring.shift.nil?
      offspring.errors.add(:shift, "no hay espacio") unless offspring.shift.sites_available?
    end
  end

end


