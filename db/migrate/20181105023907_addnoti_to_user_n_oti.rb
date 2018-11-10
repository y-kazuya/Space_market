class AddnotiToUserNOti < ActiveRecord::Migration[5.0]
  def change
    add_column :user_notifications, :about_call_4, :boolean, default: true
  end
end
