class CreateSpaceInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :space_infos do |t|
      t.integer :post_code, null: false
      t.integer :state, null: false, index: true
      t.string :city, null: false
      t.string :address, null: false
      t.string :last_address
      t.string :map_address, null: false
      t.text :access, null: false
      t.integer :phone_number, null: false
      t.integer :event_type, null: false

      t.references :user, foreign_key: true, null: false, unique: true
      t.timestamps
    end
  end
end
