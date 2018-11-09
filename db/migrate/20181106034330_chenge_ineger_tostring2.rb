class ChengeInegerTostring2 < ActiveRecord::Migration[5.0]
  def change
    change_column :company_addresses, :post_code, :string
    change_column :contacts, :phone_number, :string
    change_column :host_addresses, :post_code, :string
    change_column :host_banks, :bank_code, :string
    change_column :host_banks, :branch_code, :string
    change_column :host_banks, :account_number, :string
    change_column :host_profiles, :company_number, :string
    change_column :space_infos, :post_code, :string
    change_column :space_infos, :phone_number, :string

  end
end
