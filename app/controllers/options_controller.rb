class OptionsController < RoomEditsController
  def index
    @room = Room.find(params[:room_id])
    @options = @room.options
  end

  def show
    @option = Option.find(params[:id])
    @room = @option.room
    @option.option_pictures.build if @option.option_pictures == []

  end

  def new
    @room = Room.find(params[:room_id])
    @option = Option.new(room_id: @room.id)
    @option.option_pictures.build
  end

  def create
    @option = Option.new(option_params)
    unless @option.save
      @room = Room.find(params[:room_id])
      return render :new
    end
    redirect_to user_room_options_path(current_user.id, params[:room_id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.room.space.user.id == current_user.id
      if @option.update(option_update_params)
        return redirect_to user_room_options_path(current_user.id, @option.room.id)
      else
        @room = @option.room
        return render :show
      end
    else
      redirect_to root_path
    end
  end


  def destroy
    option = Option.find(params[:id])
    if option.room.space.user_id == current_user.id
      option.destroy
    else
      return redirect_to root_path
    end
    redirect_to user_room_options_path(current_user.id, params[:room_id])
  end

  def public
    option = Option.find(params[:id])
    if option.room.space.user_id == current_user.id
      option.public == true ? option.update(public: false) : option.update(public: true)
      redirect_to user_room_options_path(current_user.id, params[:room_id])
    else
      redirect_to root_path
    end
  end

  private
  def option_params
    params.require(:option).permit(
      :name,
      :about,
      :price,
      :unit,
      :amount,
      option_pictures_attributes: [:content, :about, :cover]
    ).merge(room_id: params[:room_id].to_i)
  end

  def option_update_params
    params.require(:option).permit(
      :name,
      :about,
      :price,
      :unit,
      :amount,
      option_pictures_attributes: [:id,:content, :about, :cover]
    ).merge(room_id: params[:room_id].to_i)
  end
end
