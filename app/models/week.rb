class Week < ApplicationRecord
  belongs_to :plan

  validates :name, presence: true #各曜日が入る
  validates :start, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 36 }, length: { maximum: 7 }
  validates :end, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 36 }, length: { maximum: 7 }
end
