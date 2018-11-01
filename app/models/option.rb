class Option < ApplicationRecord
  has_many :option_pictures, dependent: :destroy
  accepts_nested_attributes_for :option_pictures

  belongs_to :room

  validates :name, length: { maximum: 64 }
  validates :about, length: { maximum: 800 }
  validates :price, numericality: { only_integer: true, less_than_or_equal_to: 100000000000 }
  validates :unit, numericality: { only_integer: true, less_than_or_equal_to: 1000 }
  validates :amount, numericality: { only_integer: true, less_than_or_equal_to: 100000 }, allow_nil: true

  validates :name,
            :about,
            :price,
            :unit, presence: true


end
