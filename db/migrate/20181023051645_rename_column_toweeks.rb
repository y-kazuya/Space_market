class RenameColumnToweeks < ActiveRecord::Migration[5.0]
  def change
    rename_column :weeks, :start, :start_time
    rename_column :weeks, :end, :end_time
  end
end
