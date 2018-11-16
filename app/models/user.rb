class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvaterUploader

  has_many :spaces, dependent: :destroy
  has_many :space_infos, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :reserves, class_name: "Reserve", dependent: :destroy
  has_many :intend_points, dependent: :destroy

  has_one :host_profile, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_one :user_notification ,dependent: :destroy

  has_many :looks, dependent: :destroy
  has_many :rooms ,through: :looks



  after_create :make_user_noti

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :last_name, presence: true, length: { maximum: 32 }
  validates :first_name, presence: true, length: { maximum: 32 }

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :profile, length: {maximum: 800}

  has_many :favorite_lists, dependent: :destroy


  after_create :create_fav_list


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

  def active_spaces
    spaces.map{|s| s unless s.active_rooms== [] }.compact
  end

  def public_spaces #そのユーザーがもつ認証ずみspaceかつ公開済みsのルームを持つspaceを全て取得
    spaces.map{|s| s unless s.public_rooms== [] }.compact
  end

  def complete_owner_infos? #そのユーザーがスペース登録に必要なオーナー情報を全て持っているか？
    if host_profile && host_profile.host_address && host_profile.host_bank
      return true
    else
      return false
    end
  end

  def create_fav_list
    self.favorite_lists.create(name: 'お気に入りリスト')
  end

  def favalite_rooms
    a = []
    favorite_lists.each do |list|
      list.favorites.each do|f|
        a << f
      end
    end
    return a
  end


  def make_user_noti
    UserNotification.create(user_id: self.id)
  end



end
