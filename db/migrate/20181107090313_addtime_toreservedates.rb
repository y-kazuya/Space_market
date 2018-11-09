class AddtimeToreservedates < ActiveRecord::Migration[5.0]
  def change
    add_column :reserve_dates, :start_time, :string
    add_column :reserve_dates, :end_time, :string
  end
end
