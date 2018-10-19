class BasicInfoUsage < ApplicationRecord
  belongs_to :basic_info
  belongs_to :usage

  validates :basicinfo_id, presence: true
  validates :usage_id, presence: true
end
