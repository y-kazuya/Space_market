class ChengeStartToplan < ActiveRecord::Migration[5.0]
  def change
    change_column :plans, :start_day, :string
    change_column :plans, :end_day, :string
  end
end
