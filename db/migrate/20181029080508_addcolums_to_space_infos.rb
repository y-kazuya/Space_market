class AddcolumsToSpaceInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :space_infos, :fax, :integer
    add_column :space_infos, :url, :string
  end
end
