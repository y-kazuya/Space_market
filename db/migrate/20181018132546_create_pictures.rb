class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :content, null: false
      t.text :about
      t.integer :cover, null: false

      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
