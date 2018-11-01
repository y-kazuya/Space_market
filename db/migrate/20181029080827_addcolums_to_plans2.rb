class AddcolumsToPlans2 < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :start_day, :integer
    add_column :plans, :end_day, :integer
  end
end
