class Room < ApplicationRecord
  belongs_to :space
  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy

  validates :activated, inclusion: { in: [true, false] }


end
