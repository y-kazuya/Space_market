class AddcolumsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :movie, :string
  end
end
