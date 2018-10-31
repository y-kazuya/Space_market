class AddprofileTohostProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :host_profiles, :profile, :text
  end
end
