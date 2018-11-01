class Room < ApplicationRecord
  belongs_to :space, optional: true

  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_one :agreement, dependent: :destroy
  has_one :reserve_phrase, dependent: :destroy
  has_one :movie, dependent: :destroy

  has_many :options, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities


  validates :activated, presence: true
  validates :public, inclusion: { in: [true, false] }

  enum activated: %i(making waiting certification)

  def complete_infos? #そのroomが審査に必要な情報を全て持っているか？
    if space.space_info && basic_info && intro && pictures.first && plans.first
      return true
    else
      return false
    end
  end

end
