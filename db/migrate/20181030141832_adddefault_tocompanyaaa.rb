class AdddefaultTocompanyaaa < ActiveRecord::Migration[5.0]
  def change
    change_column_default :host_profiles, :company, false
    change_column_default :host_profiles, :sex, false
  end
end
