class CreateFavoriteLists < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_lists do |t|
      t.string     :name, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end

    add_index :favorite_lists,[:name ,:user_id], unique: true
  end
end
