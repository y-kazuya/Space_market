class Picture < ApplicationRecord
  belongs_to :room

  validates :content, presence: true
  validates :about, length: { maximum: 128 }
  validates :cover, presence: true

  mount_uploader :content, SpacePictureUploader
  enum cover: %i(true false)

end
