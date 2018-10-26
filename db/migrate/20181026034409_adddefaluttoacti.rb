class Adddefaluttoacti < ActiveRecord::Migration[5.0]
  def change
    change_column_default :rooms, :activated, 0
  end
end
