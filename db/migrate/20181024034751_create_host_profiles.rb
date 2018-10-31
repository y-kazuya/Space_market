class CreateHostProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :host_profiles do |t|
      t.string  :last_name,          null: false
      t.string  :first_name,         null: false
      t.string  :last_name_kata,          null: false
      t.string  :first_name_kata,         null: false
      t.integer :sex,             null: false
      t.integer :born_year ,      null: false
      t.integer :born_manth,      null: false
      t.integer :born_day,        null: false
      t.string :avatar,           null: false
      t.integer :phone_number,     null: false, unique: true
      t.string :identification,    null: false
      t.boolean :company,        null: false
      t.string :company_name
      t.string :company_name_kata
      t.string :company_name_en
      t.integer :company_number

      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
    add_index :host_profiles, [:user_id, :id]
  end
end
