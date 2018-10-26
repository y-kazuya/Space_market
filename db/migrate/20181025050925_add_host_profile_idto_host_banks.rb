class AddHostProfileIdtoHostBanks < ActiveRecord::Migration[5.0]
  def change
    add_reference :host_banks, :host_profile, foreign_key: true, index: true
  end
end
