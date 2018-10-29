class AdddefalutTodiscount < ActiveRecord::Migration[5.0]
  def change
    change_column_default :plans, :discount, 0
  end
end
