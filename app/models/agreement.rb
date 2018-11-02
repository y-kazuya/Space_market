class Agreement < ApplicationRecord
  belongs_to :room

  validates :aggree,
            :policy,
            length: { maximum: 800 }
end
