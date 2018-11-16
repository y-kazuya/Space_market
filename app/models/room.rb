class Room < ApplicationRecord
  belongs_to :space, optional: true

  has_one :basic_info, dependent: :destroy
  has_one :intro, dependent: :destroy
  has_one :agreement, dependent: :destroy
  has_one :reserve_phrase, dependent: :destroy

  has_many :options, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities
  has_many :reserves,class_name: "Reserve", dependent: :destroy


  validates :activated, presence: true
  validates :public, inclusion: { in: [true, false] }

  enum activated: %i(making waiting certification)

  def self.public_rooms
    Room.all.map{|room| room if room.activated == 'certification' && room.public == true}.compact
  end

  def complete_infos? #そのroomが審査に必要な情報を全て持っているか？
    if space.space_info && basic_info && intro && pictures.first && plans.first
      return true
    else
      return false
    end
  end

  def public_plans #公開中のプランを取得
    Plan.where(room_id: self.id).where(public: 1)
  end

  def time_low_price #roomがもつプランの中で時間がしで一番安いプランの価格を返す
    p = 1000000000000000
    public_plans.each do |plan|
      if plan.time_price
        p = plan.time_price if p > plan.time_price
      end
    end
    return p
  end

  def time_high_price #roomがもつプランの中で時間がしで一番高いプランの価格を返す
    p = 0
    public_plans.each do |plan|
      if plan.time_price
        p = plan.time_price if p < plan.time_price
      end
    end
    return p
  end

  def day_low_price #roomがもつプランの中で日がしで一番安いプランの価格を返す
    p = 1000000000000000
    public_plans.each do |plan|
      if plan.day_price
        p = plan.day_price if p > plan.day_price
      end
    end
    return p
  end

  def day_high_price #roomがもつプランの中で日がしで一番高いプランの価格を返す
    p = 0
    public_plans.each do |plan|
      if plan.day_price
        p = plan.day_price if p < plan.day_price
      end
    end
    return p
  end

end
