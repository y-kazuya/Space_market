class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.references :user, foreign_key: true, null: false
      t.references :space, foreign_key: true, null: false
      t.timestamps
    end
    add_index :admins, [:user_id, :space_id]
  end
end
