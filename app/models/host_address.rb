class HostAddress < ApplicationRecord
  belongs_to :host_profile

  VALID_KATAKANA_REGEX = /\A[ァ-ンー－]+\Z/
  VALID_POST_CODE_REGEX = /\A\d{7}\z/

  validates :post_code, presence: true, format: { with: VALID_POST_CODE_REGEX }
  validates :state, presence: true
  validates :city, presence: true, length: { maximum: 32 }
  validates :city_kata, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }
  validates :address, presence: true, length: { maximum: 32 }
  validates :address_kata, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }
  validates :last_address, presence: true, length: { maximum: 32 }
  validates :last_address_kata, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }
  validates :building, length: { maximum: 32 }
  validates :building_kata, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }, allow_blank: true



end
