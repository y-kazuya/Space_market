class RoomsController < ApplicationController
  def new
  end

  def new_first
    #この時点でuserがroomを持っていたらcurrent_user.spaces.eachでroomの存在を調べ roomがなかったらroom作成
    room = Room.new(space_id: params[:space_id])

    if room.save
      redirect_to new_space_room_space_info_path(params[:space_id], room.id)
    end
  end
end
