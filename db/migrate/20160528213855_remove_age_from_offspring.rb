class RemoveAgeFromOffspring < ActiveRecord::Migration
  def change
    remove_column :offsprings, :age, :integer
  end
end
