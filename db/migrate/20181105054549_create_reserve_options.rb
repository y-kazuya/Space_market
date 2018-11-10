class CreateReserveOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :reserve_options do |t|
      t.references :reserve, foreign_key: true, null: false
      t.references :option, foreign_key: true, null: false

      t.integer :amount, null: false, default: 1
      t.timestamps
    end
  end
end
