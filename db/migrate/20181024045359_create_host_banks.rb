class CreateHostBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :host_banks do |t|
      t.string :bank_name, null: false
      t.integer :bank_code, null: false
      t.string :branch_name, null: false
      t.integer :branch_code, null: false
      t.integer :account_number, null: false, unique: true
      t.string :account_name, null: false

      t.timestamps
    end
  end
end
