class Space < ApplicationRecord
  has_many :rooms, dependent: :destroy
  belongs_to :user
  has_one :space_info, dependent: :destroy

end
