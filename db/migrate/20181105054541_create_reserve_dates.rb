class CreateReserveDates < ActiveRecord::Migration[5.0]
  def change
    create_table :reserve_dates do |t|
      t.integer :start_date, null: false
      t.integer :end_date, null: false
      t.boolean :day ,null: false , default: false

      t.references :reserve, foreign_key: true, null: false
      t.timestamps
    end
  end
end
