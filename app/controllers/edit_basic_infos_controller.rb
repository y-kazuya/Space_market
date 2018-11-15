class EditBasicInfosController < RoomEditsController

  def show
    @room = Room.find(params[:room_id])
    @basic_info = BasicInfo.find(@room.basic_info.id)
  end

  def update
    @basic_info = BasicInfo.find_by(room_id: params[:room_id].to_i)
    @room = @basic_info.room
    if params[:basic_info][:room]
      @room.update(room_params)
    end

    if @basic_info.room.space.user.id == current_user.id
      unless @basic_info.update(basic_info_params)
        return render :show
      end
    else
      return redirect_to root_path
    end
    redirect_to user_room_basic_infos_path(current_user.id, @room.id)
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

    def room_params
      params.require(:basic_info).require(:room).permit(
        { :amenity_ids => [] }
      )
    end
end
