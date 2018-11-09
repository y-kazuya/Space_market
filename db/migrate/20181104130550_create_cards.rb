class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :num_first, null: false
      t.integer :num_seconde, null: false
      t.integer :num_thard, null: false
      t.integer :num_last, null: false

      t.string :name, null: false
      t.integer :mm, null: false
      t.integer :yy, null: false
      t.integer :code, null: false

      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
