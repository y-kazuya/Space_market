class RoomsController < ApplicationController
  def new
  end

  def new_first
    if Room.find_by(space_id: params[:space_id])
      redirect_to  space_dashboard_path(current_user.spaces.first.id)
    else
      room = Room.new(space_id: params[:space_id])
      if room.save
        redirect_to new_space_room_space_info_path(params[:space_id], room.id)
      else
        render :new_first
      end
    end
  end

end
