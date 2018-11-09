class CreateUserNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_notifications do |t|
      t.boolean :about_mail_1 ,default: true
      t.boolean :about_mail_2 ,default: true
      t.boolean :about_mail_3 ,default: true
      t.boolean :about_mail_4 ,default: true
      t.boolean :about_mail_5 ,default: true

      t.boolean :about_call_1 ,default: true
      t.boolean :about_call_2 ,default: true
      t.boolean :about_call_3 ,default: true
      t.boolean :about_mail_4 ,default: true


      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
