class CreateLooks < ActiveRecord::Migration[5.0]
  def change
    create_table :looks do |t|

      t.timestamps
    end
  end
end
