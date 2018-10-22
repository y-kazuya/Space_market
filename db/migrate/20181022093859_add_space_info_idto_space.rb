class AddSpaceInfoIdtoSpace < ActiveRecord::Migration[5.0]
  def change
    add_reference :spaces, :space_info, index: true
  end
end
