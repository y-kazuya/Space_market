class Contact < ApplicationRecord
  belongs_to :user

  validates :last_name, presence: true, length: { maximum: 32 }
  validates :first_name, presence: true, length: { maximum: 32 }

  validates :company ,inclusion: { in: [true, false] }
  validates :company_name,length: { maximum: 64 }
  validates :company_name, presence: true, if: :company?

  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { maximum: 15 }, uniqueness: true



  private
    def company?
      company == true
    end
end
