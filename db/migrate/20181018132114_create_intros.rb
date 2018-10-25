class CreateIntros < ActiveRecord::Migration[5.0]
  def change
    create_table :intros do |t|
      t.string :title, null: false, unique: true
      t.text :content, null: false
      t.text :service, null: false

      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
