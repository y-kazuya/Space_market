class RemoveEndDateToreservedates < ActiveRecord::Migration[5.0]
  def change
    remove_column :reserve_dates, :end_date
  end
end
