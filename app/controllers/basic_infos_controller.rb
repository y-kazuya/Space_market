class BasicInfosController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
    @basic_info = BasicInfo.find_by(room_id: @room.id) || BasicInfo.new(room_id: @room.id)
  end

  def create
    @basic_info = BasicInfo.new(basic_info_params)
    if @basic_info.room.space.user.id == current_user.id
      if @basic_info.save
        redirect_to new_space_room_intro_path(params[:space_id], params[:room_id])
      end
    else
      redirect_to root_path
    end
  end

  def update
    @basic_info = BasicInfo.find(params[:id])
    if @basic_info.room.space.user.id == current_user.id
      if @basic_info.update(basic_info_params)
        redirect_to new_space_room_intro_path(params[:space_id], params[:room_id])
      end
    else
      redirect_to root_path
    end
  end
  private
    def basic_info_params
      params.require(:basic_info).permit(
        :capacity,
        :floor_space,
        :key_type,
        :reserve_limit,
        :reserve_period,
        { :usage_ids => [] }
      ).merge(room_id: params[:room_id].to_i)
    end
end
