class IntrosController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
    @intro = Intro.find_by(room_id: @room.id) || Intro.new(room_id: @room.id)
  end

  def create
    @intro = Intro.new(intro_params)
    if @intro.save
      redirect_to new_space_room_picture_path(params[:space_id], params[:room_id])
    end
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
