class SpacesController < ApplicationController
  def new
    space = Space.create(user_id: current_user.id)
    room = Room.create(space_id: space.id)
    redirect_to new_space_room_space_info_path(space.id, room.id)

  end

  def new_first
    unless space = Space.find_by(user_id: current_user.id)
      space = Space.new(user_id: current_user.id)
      space.save
    end
    redirect_to new_space_room_path(space)
  end
end
