class AddPointToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :point, :integer, default: 1000
  end
end
