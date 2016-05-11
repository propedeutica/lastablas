class AddShiftIdToOffsprings < ActiveRecord::Migration
  def change
    add_reference :offsprings, :shift, index: true
  end
end
