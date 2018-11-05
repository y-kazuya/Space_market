class AddpublicToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :public, :boolean, default: true
  end
end
