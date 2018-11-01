class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :content, null: false
      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
