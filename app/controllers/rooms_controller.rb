class RoomsController < ApplicationController
  before_action :owner?, only: [:index, :newww, :stats]

  layout "room_new", only: [:index,:new, :newww, :stats, :public]


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
    if current_user
      unless Look.find_by(user_id: current_user.id, room_id: @room.id)
        Look.create(user_id: current_user.id, room_id: @room.id)
        if current_user.looks.length > 5
          current_user.looks.first.destroy
        end
      end
    end
    binding.pry
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
      room.update(activated: 2)
      return redirect_to user_rooms_path(current_user.id)
    end

    if current_user.complete_owner_infos? && room.complete_infos?
      room.update(activated: 2)
      current_user.update(owner: 1)
      redirect_to user_rooms_path(current_user.id)
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

  def public

    room = Room.find(params[:id])
    if room.space.user_id == current_user.id
      room.public == true ? room.update(public: false) : room.update(public: true)
      redirect_to :back
    else
      redirect_to root_path
    end

  end
  private
    def owner?
      redirect_to root_path if current_user.owner == false || current_user.id != params[:user_id].to_i
    end

end
