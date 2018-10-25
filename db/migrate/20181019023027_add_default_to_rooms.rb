class AddDefaultToRooms < ActiveRecord::Migration[5.0]
  def change
    change_column_default :rooms, :activated, false
  end
end
