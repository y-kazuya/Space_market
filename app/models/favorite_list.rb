class FavoriteList < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :rooms, through: :favorites

  validates :name, presence: true, uniqueness: { scope: [:user_id]  }
end
