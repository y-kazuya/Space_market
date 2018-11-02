class AddcolumsToIntro < ActiveRecord::Migration[5.0]
  def change
    add_column :intros, :food, :text
    add_column :intros, :clean, :text
    add_column :intros, :pdf, :string
  end
end
