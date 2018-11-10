class AddDayToreserves < ActiveRecord::Migration[5.0]
  def change
    add_column :reserves, :day, :boolean
  end
end
