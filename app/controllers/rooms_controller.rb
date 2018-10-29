class RoomsController < ApplicationController
  def index
    @spaces = Space.where(user_id: current_user.id).includes(:rooms)
  end

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

  def for_wating
    room =Room.find(params[:id])
    if current_user.complete_owner_infos? && room.complete_infos?
      room.update(activated: 1)
      redirect_to user_dashboard_path(current_user.id)
    else
      redirect_to :back
    end

  end

end
