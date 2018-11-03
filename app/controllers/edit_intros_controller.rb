class EditIntrosController < RoomEditsController
  def show
    @room = Room.find(params[:room_id])
    @intro = Intro.find(@room.intro.id)
  end

  def update
    @intro = Intro.find(params[:id].to_i)
    @room = @intro.room

    if @intro.room.space.user.id == current_user.id
      unless @intro.update(intro_params)
        return render :show
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
      :service,
      :food,
      :clean,
      :pdf
    ).merge(room_id: params[:room_id].to_i)
  end

end
