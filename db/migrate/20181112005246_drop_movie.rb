class DropMovie < ActiveRecord::Migration[5.0]
  def change
    drop_table :movies
    add_column :pictures, :movie, :string
  end
end
