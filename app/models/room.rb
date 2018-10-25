class Room < ApplicationRecord
  belongs_to :space
  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :room_amenities
  has_many :amenities, through: :room_amenities

  validates :activated, inclusion: { in: [true, false] }

end
