class RoomInfosController < ApplicationController
  before_action :logged_in_user?
  before_action :set_group_room , only: [:new, :info_select]



  private
  def set_group_room
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
  end

end
