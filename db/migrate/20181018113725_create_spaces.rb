class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.integer :post_code, null: false
      t.integer :state, null: false, index: true
      t.string :city, null: false
      t.string :address, null: false
      t.string :last_address
      t.string :map_address, null: false
      t.text :access, null: false
      t.integer :phone_number, null: false
      t.integer :type, null: false

      # t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
