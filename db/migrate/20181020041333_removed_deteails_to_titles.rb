class RemovedDeteailsToTitles < ActiveRecord::Migration[5.0]
  def change
    rename_column :space_infos, :type, :event_type
  end
end
