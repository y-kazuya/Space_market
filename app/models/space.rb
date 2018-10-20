class Space < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one :space_info, dependent: :destroy

    # s = Space.new(post_code: 1234567, state: 1, city:"aaa", address: "bbb", last_address: "ccc", map_address: "dddd", access: "eeee", phone_number: 00000000, type: 1 )
end
