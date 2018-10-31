class Room < ApplicationRecord
  belongs_to :space, optional: true
  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities

  validates :activated, presence: true

  enum activated: %i(making waiting certification)
end
