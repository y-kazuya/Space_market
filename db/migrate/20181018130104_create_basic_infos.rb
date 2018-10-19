class CreateBasicInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :basic_infos do |t|
      t.integer :capacity, null: false
      t.integer :floor_space, null: false
      t.integer :key_type, null: false
      t.integer :reserve_limit, null: false
      t.integer :reserve_period, null: false
      t.references :room, unique: true, foreign_key: true

      t.timestamps
    end
  end
end
