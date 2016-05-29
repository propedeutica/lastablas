class AddGradeToOffsprings < ActiveRecord::Migration
  def change
    add_column :offsprings, :grade, :integer, default: 0, null:false
  end
end
