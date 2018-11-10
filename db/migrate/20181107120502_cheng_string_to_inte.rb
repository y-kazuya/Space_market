class ChengStringToInte < ActiveRecord::Migration[5.0]
  def change
    change_column :reserve_dates, :start_date, :string
    change_column :reserve_dates, :end_date, :string
    remove_column :reserve_dates, :year
  end
end
