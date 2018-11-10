class RoomInfosController < ApplicationController
  layout "room_new"
  # layout :set_lay
  before_action :logged_in_user?
  before_action :set_group_room , only: [:new, :info_select]



  private
  def set_group_room
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
  end

  def set_lay
    return "host" if current_user.owner == true
  end

end
