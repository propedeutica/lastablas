class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :day_of_week
      t.datetime :start_time
      t.datetime :end_time
      t.integer :prebooked
      t.references :room, index: true, foreign_key: true

      t.timestamps
    end
  end
end
