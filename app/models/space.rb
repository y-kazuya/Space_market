class Space < ApplicationRecord
 has_many :rooms, dependent: :destroy
 belongs_to :user
 belongs_to :space_info, optional: true

 def acti_rooms
   rooms.map{|room| room if room.activated == 2}.compact!
 end

end
