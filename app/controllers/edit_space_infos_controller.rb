class EditSpaceInfosController < RoomEditsController

  def index
    @room = Room.find(params[:room_id])
    @space_infos = current_user.space_infos
  end

  def new
    @room = Room.find(params[:room_id])
    @space_info = SpaceInfo.new
  end

  def show
    @space_info = SpaceInfo.find(params[:id])
    @room = Room.find(params[:room_id])

  end


  def create
    @space_info = SpaceInfo.new(space_info_params)
    @room = Room.find(params[:room_id])
    space = @room.space

    if @space_info.save
      space.update(space_info_id: @space_info.id)
    else
      return render :new
    end
    redirect_to user_room_space_infos_path(current_user.id, params[:room_id])
  end

  def update
    @space_info = SpaceInfo.find(params[:id])
    if @space_info.user_id == current_user.id
      if @space_info.update(space_info_params)
        return redirect_to user_room_space_infos_path(current_user.id, params[:room_id])
      else
        @room = Room.find(params[:rom_id])
        return render :show
      end
    else
      redirect_to root_path
    end
  end

  def chose
    space_info = SpaceInfo.find(params[:id])
    @room = Room.find(params[:room_id])
    space = @room.space
    if space_info.user_id == current_user.id
      space.update(space_info_id: space_info.id) unless space.space_info_id == space_info.id
      return redirect_to user_room_space_infos_path(current_user.id, @room.id)
    end
    redirect_to root_path
  end



  def destroy
    space_info = SpaceInfo.find(params[:id])

    unless current_user.space_infos.count == 1
      if space_info.space == nil
        if space_info.user_id == current_user.id
          space_info.destroy
        else
          return redirect_to root_path
        end
      end
    end
    redirect_to user_room_space_infos_path(current_user.id, params[:room_id])
  end


  private
  def space_info_params
    params.require(:space_info).permit(
      :title,
      :post_code,
      :state,
      :city,
      :address,
      :last_address,
      :map_address,
      :access,
      :phone_number,
      :event_type,
      :fax,
      :url,
    ).merge(user_id: current_user.id)
  end

end
