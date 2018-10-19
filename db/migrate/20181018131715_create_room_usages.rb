class CreateRoomUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :room_usages do |t|
      t.references :room, foreign_key: true, null: false
      t.references :usage, foreign_key: true, null: false
      t.timestamps
    end
    add_index :room_usages, [:room_id, :usage_id], unique: true
  end
end
