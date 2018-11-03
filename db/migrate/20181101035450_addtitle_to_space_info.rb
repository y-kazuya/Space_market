class AddtitleToSpaceInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :space_infos, :title, :string
  end
end
