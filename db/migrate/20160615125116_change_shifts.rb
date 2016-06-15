class ChangeShifts < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :shifts do |t|
        dir.up  do
          t.change :start_time, :string
          t.change :end_time, :string
        end
        dir.down do
          t.change :start_time, :datetime
          t.change :end_time, :datetime
        end
      end
    end
  end
end
