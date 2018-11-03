class ReservePhrase < ApplicationRecord
  belongs_to :room

  validates :success,
            :fail,
            :remind,
            presence: true, length: { maximum: 800 }
end
