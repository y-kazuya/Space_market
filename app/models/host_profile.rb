class HostProfile < ApplicationRecord
  belongs_to :user
  has_one :host_bank
  has_one :host_address
  has_one :company_address
end
