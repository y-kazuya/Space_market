class Usage < ApplicationRecord
  has_and_belongs_to_many :basic_infos, dependent: :destroy

  validates :name, presence: true, uniqueness: true


end
