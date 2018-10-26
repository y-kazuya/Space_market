class AmenitiesController < ApplicationController
  def new
    # @amenity = Amenity.find_by(room_id: params[:room_id]) || Amenity.new(room_id: params[:room_id])
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    if @room.update(amenity_params)
      redirect_to new_space_room_amenity_path(params[:space_id], params[:room_id])
    else
      @room = @amenity.room
      @space = @room.space
      render :new
    end
  end

  def amenity_params
    params.require(:room).permit(
      { :amenity_ids => [] }
    )
  end
end
