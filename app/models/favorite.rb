class Favorite < ApplicationRecord
  belongs_to :room
  belongs_to :favorite_list

  validates :room_id, uniquness: { scope: [:favorite_list_id]  }
end
