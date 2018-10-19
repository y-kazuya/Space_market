class Intro < ApplicationRecord
  belongs_to :room

  validates :title, presence: true, uniqueness: true, length: { maximum: 64 }
  validates :content, presence: true, length: { in: 10..500 }
  validates :service, presence: true, length: { maximum: 500 }


end
