class Addww < ActiveRecord::Migration[5.0]
  def change
    create_table :weeks do |t|
      t.string :name, null: false
      t.integer :start, null: false
      t.integer :end, null: false

      t.references :plan, foreign_key: true, index: true
      t.timestamps
    end
  end
end
