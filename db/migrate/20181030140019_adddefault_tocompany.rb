class AdddefaultTocompany < ActiveRecord::Migration[5.0]
  def change
    change_column_default :host_profiles, :company, 0
    change_column_default :host_profiles, :sex, 0
    add_column :plans, :public, :boolean, default: true
    change_column_default :plans, :time_pay, 1
    change_column_default :plans, :about_reserve, 1
    change_column_default :weeks, :can, 1
  end
end
