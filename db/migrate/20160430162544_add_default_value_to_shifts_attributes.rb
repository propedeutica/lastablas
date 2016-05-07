class AddDefaultValueToShiftsAttributes < ActiveRecord::Migration
  def change
    change_column_null  :shifts, :day_of_week, false
    change_column_default :shifts, :day_of_week, "1"
    change_column_null :shifts, :prebooked, false
    change_column_default :shifts, :prebooked, "0"
    change_column_null :shifts, :start_time, false
    change_column_null :shifts, :end_time, false
  end

end
