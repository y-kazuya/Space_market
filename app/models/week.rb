class Week < ApplicationRecord
  belongs_to :plan, optional: true

  validates :start, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 36 }
  validates :end, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 36 }
  validates :can, inclusion: { in: [true, false] }
end
