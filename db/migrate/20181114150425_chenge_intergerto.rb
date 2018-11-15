class ChengeIntergerto < ActiveRecord::Migration[5.0]
  def change
    change_column :host_profiles, :phone_number, :string

  end
end
