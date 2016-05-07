class Offspring < ActiveRecord::Base
  belongs_to :user
  validates :first_name, :presence => true, length: { within: 3..60 }
  validates :last_name, :presence => true, length: { within: 3..60 }
  validates :age, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 18 }
  validates :user, :presence => true
end
