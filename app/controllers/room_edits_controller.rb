class RoomEditsController < ApplicationController
  before_action :owner?
  # before_action :set_spaces
  layout "room_edit"




  private
    def owner?
      redirect_to root_path if current_user.owner == false || current_user.id != params[:user_id].to_i
    end


end
