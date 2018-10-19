class RenameTypeColumnToSpaces < ActiveRecord::Migration[5.0]
  def change
    rename_column :spaces, :type, :event_type
  end
end
