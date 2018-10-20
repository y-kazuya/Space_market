class PicturesController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
    @picture = Picture.find_by(room_id: @room.id) || Picture.new(room_id: @room.id)
  end

  def create
    @picture = Picture.new(picture_params)
    binding.pry
    #ok!
    # if @intro.save
    #   redirect_to (params[:space_id], params[:room_id])
    # end
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
