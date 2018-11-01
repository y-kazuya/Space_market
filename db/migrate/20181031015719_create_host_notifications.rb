class CreateHostNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :host_notifications do |t|
      t.boolean :about_mail_1 ,default: true
      t.boolean :about_mail_2 ,default: true
      t.boolean :about_mail_3 ,default: true
      t.boolean :about_mail_4 ,default: true
      t.boolean :about_mail_5 ,default: true
      t.boolean :about_mail_6 ,default: true

      t.boolean :about_call_1 ,default: true
      t.boolean :about_call_2 ,default: true
      t.boolean :about_call_3 ,default: true


      t.references :host_profile, foreign_key: true, null: false
      t.timestamps
    end
  end
end
