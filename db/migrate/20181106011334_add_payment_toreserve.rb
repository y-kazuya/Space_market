class AddPaymentToreserve < ActiveRecord::Migration[5.0]
  def change
    add_column :reserves, :activated, :boolean, default: false
  end
end
