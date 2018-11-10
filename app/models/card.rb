class Card < ApplicationRecord
  belongs_to :user

  VALID_ALFAVET_REGEX = /\A[a-zA-Z]+\Z/

  validates :num_first,
            :num_seconde,
            :num_thard,
            :num_last,
            presence: true,
            numericality: { only_integer: true },
            length: { is: 4 }

  validates :code,
            presence: true,
            numericality: { only_integer: true },
            length: { is: 3 }

  validates :name,
            presence: true,
            length: { maximum: 64 },
            format: { with: VALID_ALFAVET_REGEX , message: 'はアルファベットで入力して下さい。' }

  validates :yy,
            :mm,
            presence: true,
            numericality: { only_integer: true }

end
