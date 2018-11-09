class Reserve < ApplicationRecord

  belongs_to :user
  belongs_to :room
  belongs_to :plan
  belongs_to :card

  has_many :reserve_dates, dependent: :destroy
  accepts_nested_attributes_for :reserve_dates
  has_many :reserve_options,dependent: :destroy
  has_many :options, through: :reserve_options

  validates :day,
            :company,
            :activated,
            :coupon,
            inclusion: { in: [true, false] }

  validates :card_id,
            :purpose,
            :payment,
            :people,
            presence: true

  validate :need_reserve_day






  enum purpose: {
    指定なし:0, パーティー:1, 会議・研修:2, 写真撮影:3, ロケ撮影:4,
    イベント:5, 個展・展示会:6, スポーツフィットネス:7, オフィス:8,
    結婚式:9 ,その他:10
  }

  private

    def need_reserve_day
      errors.add(:resrve_dates, "予約日を選択してください") if reserve_dates == []
    end
end
