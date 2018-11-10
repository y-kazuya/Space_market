class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :phone_number, null: false
      t.boolean :company, null: false ,default: false
      t.string :company_name

      t.references :user,          foreign_key: true, null: false
      t.timestamps
    end
  end
end
