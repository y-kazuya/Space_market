class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.boolean :activated, default: false
      t.references :space, index: true, foreign_key: true
      t.timestamps
    end
  end
end
