class Space < ApplicationRecord
 has_many :rooms, dependent: :destroy
 belongs_to :user
 belongs_to :space_info, optional: true


 def self.active_spaces #認証済みのroomをもつspace を全部取ってくる
  Space.all.includes(:rooms).map{|s| s unless s.active_rooms == []}.compact
 end

 def self.waiting_spaces #認証待ちのroomをもつspaceを全部取ってくる
  Space.all.includes(:rooms).map{|s| s unless s.waiting_rooms == []}.compact
 end

 def active_rooms #そのスペースex)user.spaces.first が持っている認証ずみroom
   rooms.map{|room| room if room.activated == "certification"}.compact!
 end

 def waiting_rooms #そのスペースex)user.spaces.first が持っている認証待ちのroom
  rooms.map{|room| room if room.activated == "waiting"}.compact!
 end


end
