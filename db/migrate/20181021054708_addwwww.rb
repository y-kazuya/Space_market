class Addwwww < ActiveRecord::Migration[5.0]
  def change
    create_table :weeks do |t|
      t.string :name, null: false
      t.integer :start, null: false
      t.integer :end, null: false

      t.references :plan, foreign_key: true
      t.timestamps
    end
    add_index :weeks, [:name, :plan_id], unique: true
  end
end
