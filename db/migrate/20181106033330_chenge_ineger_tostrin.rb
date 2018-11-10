class ChengeInegerTostrin < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :code, :string
    change_column :cards, :num_first, :string
    change_column :cards, :num_seconde, :string
    change_column :cards, :num_thard, :string
    change_column :cards, :num_last, :string
  end
end
