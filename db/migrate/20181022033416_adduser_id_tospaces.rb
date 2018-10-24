class AdduserIdTospaces < ActiveRecord::Migration[5.0]
  def change
    add_reference :spaces, :user, index: true
  end

end
