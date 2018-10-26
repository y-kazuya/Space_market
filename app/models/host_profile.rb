class HostProfile < ApplicationRecord
  belongs_to :user
  has_one :host_bank
  has_one :host_address
  has_one :company_address

  mount_uploader :avatar, AvaterUploader
  mount_uploader :identification, IdentificationUploader

  VALID_ALFAVET_REGEX = /\A[a-zA-Z]+\Z/
  VALID_KATAKANA_REGEX = /\A[ァ-ンー－]+\Z/

  validates :last_name, presence: true, length: { maximum: 32 }
  validates :first_name, presence: true, length: { maximum: 32 }
  validates :last_name_kata, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }
  validates :first_name_kata, presence: true, length: { maximum: 32 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }
  validates :sex, presence: true
  validates :born_year, presence: true, numericality: { only_integer: true,less_than: 2018, greater_than: 1899 }
  validates :born_manth, presence: true, numericality: { only_integer: true,less_than: 13, greater_than: 0 }
  validates :born_day, presence: true, numericality:{ only_integer: true,less_than: 32, greater_than: 0 }
  validates :avatar, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { maximum: 15 }, uniqueness: true
  validates :identification, presence: true

  validates :company ,inclusion: { in: [true, false] }

  validates :company_name,length: { maximum: 64 }
  validates :company_name_kata, length: { maximum: 64 },format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい。' }, allow_blank: true
  validates :company_name_en,length: { maximum: 64 },format: { with: VALID_ALFAVET_REGEX , message: 'はアルファベットで入力して下さい。' }, allow_blank: true
  validates :company_number,numericality: { only_integer: true }, length: { maximum: 10 }, allow_nil: true



  validates :company_name,
  :company_number,
  :company_name_kata,
  :company_name_en,
  :company_number,
  presence: true, if: :company?

  enum sex: %i(male female)

  private
    def company?
      company == true
    end
end
