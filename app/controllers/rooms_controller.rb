class RoomsController < ApplicationController
  def index
    @spaces = Space.where(user_id: current_user.id).includes(:rooms)
  end

  def new
  end

  def newww
  end

  def show
    @room = Room.find(params[:id])
    @space = @room.space
  end

  def stats
    @room = Room.find(params[:id])
    @space = @room.space
  end

  def destroy
    room = Room.find(params[:id])
    if room.space.user_id == current_user.id
      room.space.destroy
      return redirect_to user_rooms_path(current_user.id)
    end
    redirect_to root_path

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
    if current_user.owner == true
      room.update(activated: 1)
      return redirect_to user_rooms_path(current_user.id)
    end

    if current_user.complete_owner_infos? && room.complete_infos?
      room.update(activated: 1)
      current_user.update(owner: 1)
      redirect_to user_dashboard_path(current_user.id)
    else
      redirect_to :back
    end
  end

  def cancel_policy
    @room = Room.find(params[:id])
  end

  def terms
    @room = Room.find(params[:id])
  end

end
