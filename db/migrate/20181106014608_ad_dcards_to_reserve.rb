class AdDcardsToReserve < ActiveRecord::Migration[5.0]
  def change
    add_reference :reserves, :card, index: true
  end
end
