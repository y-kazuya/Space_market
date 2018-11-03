class AddOwnerTousers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :owner, :boolean, default: false
  end
end
