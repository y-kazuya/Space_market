class CreateBasicInfoUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :basic_info_usages do |t|
      t.references :basic_info, foreign_key: true, null: false
      t.references :usage, foreign_key: true, null: false
      t.timestamps
    end
    add_index :basic_info_usages, [:basic_info_id, :usage_id]
  end
end
