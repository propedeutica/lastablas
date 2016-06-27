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
  validates_each :shift, allow_nil:true do |offspring|
      offspring.errors.add(:shift, "no hay espacio") unless offspring.shift.sites_available?
  end
  validates_each :last_name do |offspring|
    if offspring.user && offspring.user.offsprings.first then
      offspring.errors.add(:last_name, "tiene que coincidir con el de sus hermanos") unless offspring.last_name==offspring.user.offsprings.first.last_name
    end
  end

end
