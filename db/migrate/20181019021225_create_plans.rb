class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.text :about
      t.boolean :day_pay, null: false
      t.integer :day_price
      t.boolean :time_pay, null: false
      t.integer :time_price


      t.boolean :about_reserve, null: false, null: false
      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
