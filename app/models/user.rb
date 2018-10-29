class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvaterUploader
  has_many :spaces
  has_many :space_infos
  has_many :favorite_lists, dependent: :destroy

  after_create :create_fav_list

  def create_fav_list
    self.favorite_lists.create(name: 'お気に入りリスト')
  end
end
