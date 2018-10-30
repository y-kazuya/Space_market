class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      create_table :favorites do |t|
      t.references :room,          foreign_key: true, null: false
      t.references :favorite_list, foreign_key: true, null: false
      t.timestamps
    end

    add_index :favorites,[:favorite_list_id ,:room_id], unique: true
  end
end
