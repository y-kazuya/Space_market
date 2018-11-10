class AddUserTocards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :use, :boolean
  end
end
