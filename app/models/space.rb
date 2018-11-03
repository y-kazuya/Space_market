class Space < ApplicationRecord
  has_many :rooms, dependent: :destroy
  belongs_to :user
  belongs_to :space_info, optional: true

  has_many :admins, dependent: :destroy

  def self.active_spaces #認証済みのroomをもつspace を全部取ってくる
    Space.all.includes(:rooms).map{|s| s unless s.active_rooms == []}.compact
  end

  def self.public_spaces #認証済みかつ公開許可roomをもつスペース
    Space.joins(:rooms).where(rooms: {activated: "certification" }).where(rooms: {public: true }).distinct.includes(:space_info)
  end

  def self.waiting_spaces #認証待ちのroomをもつspaceを全部取ってくる
    Space.all.includes(:rooms).map{|s| s unless s.waiting_rooms == []}.compact
  end

  def active_rooms #そのスペースex)user.spaces.first が持っている認証ずみroom
    rooms.map{|room| room if room.activated == "certification"}.compact!
  end

  def public_rooms #そのスペースex)user.spaces.first が持っている認証ずみroomかつ公開許可room
    Room.where(space_id: self.id).where(activated: "certification" ).where(public: true ).distinct
  end

  def waiting_rooms #そのスペースex)user.spaces.first が持っている認証待ちのroom
    rooms.map{|room| room if room.activated == "waiting"}.compact!
  end


end
