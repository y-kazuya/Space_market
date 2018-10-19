class BasicInfo < ApplicationRecord
  belongs_to :room
  has_and_belongs_to_many :usages, dependent: :destroy

  validates :capacity, presence: true, numericality: { only_integer: true }, length: { maximum: 7 }
  validates :floor_space, presence: true, numericality: { only_integer: true }, length: { maximum: 15 }
  validates :key_type, presence: true, numericality: { only_integer: true }
  validates :reserve_limit, presence: true, numericality: { only_integer: true }
  validates :reserve_period, presence: true, numericality: { only_integer: true }

  enum key_type: {
    対面:1, キーボックス:2, スマートロック:3, 予約成立後にメッセージで伝える:4
  }

  enum reserve_limit: {
    利用日当日:1, 利用日の1日前:2, 利用日の2日前: 3, 利用日の3日前: 4, 利用日の7日前: 5, 利用日の14日前: 6
  }

  enum reserve_period: {
    三ヶ月先: 1, 六ヶ月先: 2, 九ヶ月先: 3, 十二ヶ月先: 4
  }
end
