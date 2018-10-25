class CreateRoomAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :room_amenities do |t|
      t.references :amenity, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
