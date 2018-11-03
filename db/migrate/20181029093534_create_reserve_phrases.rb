class CreateReservePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :reserve_phrases do |t|
      t.text :success
      t.text :fail
      t.text :remind

      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
