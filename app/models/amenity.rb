class Amenity < ApplicationRecord
  has_many :rooms, through: :room_amenities
  has_many :room_amenities, dependent: :destroy
  validates :name, presence: true, uniqueness: true


end
