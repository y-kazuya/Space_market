class ChengeActiToRooms < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :activated, :integer, null: false
  end
end
