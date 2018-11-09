class EditPicturesController < RoomEditsController

  def show
    @room = Room.find(params[:room_id])
    @movie = Movie.find_by(room_id: @room.id) || Movie.new(room_id: @room_id)
    @pictures = Picture.where(room_id: @room.id)
  end

  def create
    @movie = Movie.new(movie_params)

    unless @movie.save
      @room = Room.find(params[:room_id])
      @pictures = Picture.where(room_id: @room.id)
      render :show
    end

   redirect_to user_room_pictures_path(current_user.id, params[:room_id])


  end

  def update
    @room = Room.find(params[:room_id])
    @movie = Movie.find(@room.movie.id)

    unless @movie.update(movie_params)
      @pictures = Picture.where(room_id: @room.id)
      return render :show
    end
   redirect_to user_room_pictures_path(current_user.id, params[:room_id])

  end

  def destroy
  end

  private
    def picture_params
      params.require(:picture).permit(
        :content,
        :about,
        :cover
      ).merge(room_id: params[:room_id].to_i)
    end

    def movie_params
      params.require(:movie).permit(
        :content
      ).merge(room_id: params[:room_id].to_i)
    end

end
