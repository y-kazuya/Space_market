class CreateReserves < ActiveRecord::Migration[5.0]
  def change
    create_table :reserves do |t|
      t.boolean :company, null: false, defalut: 0
      t.integer :payment, null: false
      t.integer :purpose, null: false
      t.integer :people, null: false
      t.text :usage
      t.boolean :coupon, null: false ,default: 0
      t.integer :price

      t.references :user, foreign_key: true, null: false
      t.references :plan, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
    add_index :reserves, [:user_id, :created_at], unique: true
  end
end
