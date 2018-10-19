class Space < ApplicationRecord
  has_many :rooms

  VALID_POST_CODE_REGEX = /\A\d{7}\z/
  validates :post_code, presence: true, format: { with: VALID_POST_CODE_REGEX }
  validates :state, presence: true, numericality: { only_integer: true }
  validates :city, presence: true, length: { maximum: 64 }
  validates :address, presence: true, length: { maximum: 128}
  validates :last_address, length: { maximum: 128}
  validates :map_address, presence: true, length: { maximum: 128}
  validates :access, presence: true, length: { maximum: 500}
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { maximum: 64 }
  validates :event_type, presence: true, numericality: { only_integer: true }

  enum state: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }

  enum event_type: {
    イベントスペース:1 ,結婚式場:2, オフィススペース:3, ホール:4, 貸し会議室:5, スタジオ:6, カフェ:7,
    レストラン:8, 映画館:9, ギャラリー:10, バー:11, スポーツ施設:12, ホテル:13, 住宅:14,
    倉庫:15, ワイナリー・蔵:16, その他:17}


    # s = Space.new(post_code: 1234567, state: 1, city:"aaa", address: "bbb", last_address: "ccc", map_address: "dddd", access: "eeee", phone_number: 00000000, type: 1 )
end
