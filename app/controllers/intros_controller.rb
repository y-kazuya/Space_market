class IntrosController < RoomInfosController
  def new
    @intro = Intro.find_by(room_id: @room.id) || Intro.new(room_id: @room.id)
  end

  def create
    @intro = Intro.new(intro_params)
    if @intro.save
      redirect_to new_space_room_picture_path(params[:space_id], params[:room_id])
    else
      @room = @intro.room
      @space = @room.space
      render :new
    end
  end

  def update
    @intro = Intro.find(params[:id])
    @room = @intro.room
    if @intro.room.space.user.id == current_user.id
      if @intro.update(intro_params)
        return redirect_to new_space_room_picture_path(params[:space_id], params[:room_id])
      else
        @space = @room.space
        return render :new
      end
    else
      return redirect_to root_path
    end
    redirect_to user_room_intros_path(current_user.id, @room.id)
  end

  private
    def intro_params
      params.require(:intro).permit(
        :title,
        :content,
        :service
      ).merge(room_id: params[:room_id].to_i)
    end
end
