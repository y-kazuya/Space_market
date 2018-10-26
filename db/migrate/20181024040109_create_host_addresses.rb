class CreateHostAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :host_addresses do |t|
      t.integer :post_code, null: false
      t.integer :state, null: false
      t.string :city, null: false
      t.string :city_kata, null: false
      t.string :address, null: false
      t.string :address_kata, null: false
      t.string :last_address, null: false
      t.string :last_address_kata, null: false
      t.string :building
      t.string :building_kata


      t.references :host_profile, index: true, foreign_key: true
      t.timestamps
    end
  end
end
