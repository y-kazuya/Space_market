class RoomAmenity < ApplicationRecord
  belongs_to :amenity
  belongs_to :room
end
