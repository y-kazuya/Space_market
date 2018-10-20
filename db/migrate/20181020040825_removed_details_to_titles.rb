class RemovedDetailsToTitles < ActiveRecord::Migration[5.0]
  def change
    remove_column :spaces, :event_type
  end
end
