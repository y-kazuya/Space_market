class PicturesController < RoomInfosController
  def new
    @picture = Picture.find_by(room_id: @room.id) || Picture.new(room_id: @room.id)
    # if Picture.where(room_id: @room.id) == []
    #   @pictures = @room.pictures.build
    # else
    #   @pictures = Picture.where(room_id: @room.id)
    # end
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to new_space_room_plan_path(params[:space_id], params[:room_id])
    else
      @room = @picture.room
      @space = @room.space
      render :new
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.room.space.user.id == current_user.id
      if @picture.update(picture_params)
        redirect_to new_space_room_plan_path(params[:space_id], params[:room_id])
      else
        @room = @picture.room
        @space = @room.space
        render :new
      end
    else
      redirect_to root_path
    end
  end

  private
    def picture_params
      params.require(:picture).permit(
        :content,
        :about,
        :cover
      ).merge(room_id: params[:room_id].to_i)
    end
end
