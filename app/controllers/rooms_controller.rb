class RoomsController < ApplicationController
  def new
  end

  def new_first
    room = Room.new(space_id: params[:space_id])

    if room.save
      redirect_to new_space_room_space_info_path(params[:space_id], room.id)
    end
  end
end
