class Space < ApplicationRecord
  has_many :rooms, dependent: :destroy
  belongs_to :user
  belongs_to :space_info, optional: true
end
