class AddYeaToreservedate < ActiveRecord::Migration[5.0]
  def change
    add_column :reserve_dates, :year, :string
  end
end