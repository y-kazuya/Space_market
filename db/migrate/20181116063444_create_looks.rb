class CreateLooks < ActiveRecord::Migration[5.0]
  def change
    create_table :looks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
    add_index :looks, [:user_id, :room_id], unique: true
  end
end
