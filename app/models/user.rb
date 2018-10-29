class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvaterUploader
  has_many :spaces
  has_many :space_infos
  has_one :host_profile

  def self.active_owners #User.active_owners で認証済みのroomをもつuserを全て取得
    User.all.includes(spaces: :rooms).map{|u| u if u.active_owner?}.compact
  end

  def active_owner? #そのユーザーが認証済みのroomを持っていたら true
    if active_spaces == []
      return false
    else
      return true
    end
  end

  def waiting_owner? #そのユーザーが認証待ちのroomを持っていたらtrue
    spaces.each do |space|
      return true unless space.waiting_rooms == []
    end
    return false
  end

  def active_spaces #そのユーザーがもつ認証ずみspaceを全て取得
    spaces.map{|s| s unless s.active_rooms == [] }.compact
  end

  def complete_owner_infos? #そのユーザーがスペース登録に必要なオーナー情報を全て持っているか？
    if host_profile && host_profile.host_address && host_profile.host_bank
      return true
    else
      return false
    end
  end

end
