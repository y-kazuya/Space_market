class HostBank < ApplicationRecord
  belongs_to :host_profile

  VALID_KATAKANA_REGEX = /\A[ァ-ンー－]+\Z/

  validates :bank_name, presence: true, length: { maximum: 32 }
  validates :bank_code, presence: true, numericality:{ only_integer: true }
  validates :branch_name, presence: true, length: { maximum: 32 }
  validates :branch_code, presence: true, numericality:{ only_integer: true }
  validates :account_number, presence: true, numericality:{ only_integer: true }
  validates :account_name, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }

end
