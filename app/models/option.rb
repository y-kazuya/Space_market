class Option < ApplicationRecord
  has_many :option_pictures, dependent: :destroy
end
