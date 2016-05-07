class CreateOffsprings < ActiveRecord::Migration
  def change
    create_table :offsprings do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
