class SpaceInfosController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
    @space_info = SpaceInfo.find_by(space_id: @space.id) || SpaceInfo.new(space_id: @space.id)
  end

  def create
    @space_info = SpaceInfo.new(space_info_params)
    if @space_info.space.user.id == current_user.id
      if @space_info.save
        redirect_to new_space_room_basic_info_path(params[:space_id], params[:room_id])
      end
    else
      redirect_to root_path
    end
  end

  def update
    @space_info = SpaceInfo.find(params[:id])
    if @space_info.space.user.id == current_user.id
      if @space_info.update(space_info_params)
        redirect_to new_space_room_basic_info_path(params[:space_id], params[:room_id])
      end
    else
      redirect_to root_path
    end
  end

  private
    def space_info_params
      params.require(:space_info).permit(
        :post_code,
        :state,
        :city,
        :address,
        :last_address,
        :map_address,
        :access,
        :phone_number,
        :event_type,
      ).merge(space_id: params[:space_id].to_i)
    end
end
