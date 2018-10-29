class CreateAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :agreements do |t|
      t.text :aggree
      t.text :policy

      t.references :room, foreign_key: true, null: false
      t.timestamps
    end
  end
end
