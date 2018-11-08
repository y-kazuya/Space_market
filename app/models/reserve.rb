class Reserve < ApplicationRecord

  belongs_to :user
  belongs_to :room
  belongs_to :plan
  belongs_to :card

  has_many :reserve_dates, dependent: :destroy
  accepts_nested_attributes_for :reserve_dates
  has_many :reserve_options,dependent: :destroy
  has_many :options, through: :reserve_options

  validates :card_id ,length: {maximum: 10},allow_nil: true

  enum purpose: {
    指定なし:0, パーティー:1, 会議・研修:2, 写真撮影:3, ロケ撮影:4,
    イベント:5, 個展・展示会:6, スポーツフィットネス:7, オフィス:8,
    結婚式:9 ,その他:10
  }

  private
    def reject_dates(attributed)
      attributed['start_date'].blank?
      # reject_if: :reject_dates
    end
end
