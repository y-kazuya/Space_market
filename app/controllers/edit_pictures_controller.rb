class EditPicturesController < RoomEditsController

  def show
    @room = Room.find(params[:room_id])
    @picture = Picture.where(room_id: @room.id).first
  end

  def update
    @room = Room.find(params[:room_id])
    @picture = @room.pictures.first

    if @picture.room.space.user.id == current_user.id
      if @picture.update(picture_params)
        return redirect_to user_room_pictures_path(current_user.id, params[:room_id])
      else
        @room = @picture.room
        @space = @room.space
        return render :show
      end
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private
    def picture_params
      params.require(:picture).permit(
        :content,
        :about,
        :cover,
        :movie
      ).merge(room_id: params[:room_id].to_i)
    end

    def movie_params
      params.require(:movie).permit(
        :content
      ).merge(room_id: params[:room_id].to_i)
    end

end
