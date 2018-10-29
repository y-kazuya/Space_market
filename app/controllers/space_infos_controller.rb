class SpaceInfosController < RoomInfosController
  def new
    @space_info = SpaceInfo.new
  end

  def edit

  end

  def create
    @space_info = SpaceInfo.new(space_info_params)
    @space = Space.find(params[:space_id])

    if @space_info.save
      @space.update(space_info_id: @space_info.id)
      redirect_to new_space_room_basic_info_path(params[:space_id], params[:room_id])
    else
      @room = Room.find(params[:room_id])
      render :new
    end
  end

  def update
    @space_info = SpaceInfo.find(params[:id])
    if @space_info.user.id == current_user.id
      if @space_info.update(space_info_params)
        redirect_to new_space_room_basic_info_path(params[:space_id], params[:room_id])
      else
        @space = Space.find(params[:space_id])
        @room = Room.find(params[:room_id])
        render :new
      end
    else
      redirect_to root_path
    end
  end


  def info_select
    @space_infos = current_user.space_infos
  end

  def choise_info
    @space = Space.find(params[:space_id])
    if @space.user.id == current_user.id
      if @space.update(info_choise_params)
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
      ).merge(user_id: current_user.id)
    end

    def info_choise_params
      params.permit(:space_info_id)
    end
end
