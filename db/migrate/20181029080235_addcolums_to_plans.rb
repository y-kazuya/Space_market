class AddcolumsToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :min_time, :integer
    add_column :plans, :clean_time, :integer
    add_column :plans, :discount, :integer, defalut: 0
    add_column :plans, :cost, :integer
  end
end
