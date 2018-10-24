class Usage < ApplicationRecord
  # has_and_belongs_to_many :basic_infos, dependent: :destroy
  has_many :basic_info_usages, dependent: :destroy
  has_many :basic_infos, through: :basic_info_usages

  validates :name, presence: true, uniqueness: true


end
