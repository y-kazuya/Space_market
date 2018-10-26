class Room < ApplicationRecord
  belongs_to :space
  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_lists, through: :favorites

  validates :activated, presence: true

  enum activated: %i(making waiting certification)
end
