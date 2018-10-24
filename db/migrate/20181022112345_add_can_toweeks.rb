class AddCanToweeks < ActiveRecord::Migration[5.0]
  def change
    add_column :weeks, :can, :boolean
  end
end
