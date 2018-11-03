class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :name , null: false
      t.text :about
      t.integer :price, null: false
      t.integer :unit , null: false
      t.integer :amount

      t.boolean :public, default: true
      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
