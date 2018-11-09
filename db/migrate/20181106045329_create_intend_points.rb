class CreateIntendPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :intend_points do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :point, null: false
      t.string :date, null: false

      t.timestamps
    end
  end
end
