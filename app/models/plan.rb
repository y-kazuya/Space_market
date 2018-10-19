class Plan < ApplicationRecord
  belongs_to :room
  has_many :weeks

  validates :name, presence: true, length: { maximum: 64 }
  validates :about, length: { maximum: 500 }

  validates :day_pay, inclusion: { in: [true, false] }
  validates :day_price, presence: true, numericality: { only_integer: true }, length: { maximum: 10 } #day_pay がtrueの時のみ presenceをtrueに

  validates :time_pay, inclusion: { in: [true, false] }
  validates :time_price, presence: true, numericality: { only_integer: true }, length: { maximum: 10 } #time_pay がtrueの時のみ presenceをtrueに

  validates :about_reserve, inclusion: { in: [true, false] }
end
