class OptionPicture < ApplicationRecord
  belongs_to :option, optional: true
  mount_uploader :content, SpacePictureUploader
end
