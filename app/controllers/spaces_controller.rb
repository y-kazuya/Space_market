class SpacesController < ApplicationController

  before_action :set_check_space, only: :show
  def new
    space = Space.create(user_id: current_user.id)
    room = Room.create(space_id: space.id)
    redirect_to new_space_room_space_info_path(space.id, room.id)

  end

  def show
    @space = Space.find(params[:id])
    @space_info = @space.space_info
    @host = @space.user.host_profile

  end

  def new_first
    unless space = Space.find_by(user_id: current_user.id)
      space = Space.new(user_id: current_user.id)
      space.save
    end
    redirect_to new_space_room_path(space)
  end

  private
    def set_check_space
      @space = Space.find(params[:id])
      redirect_to root_path if @space.public_rooms == []
    end
end
