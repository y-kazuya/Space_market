class SpacesController < ApplicationController
  def new
    space = Space.new

    if space.save
      redirect_to new_space_room_path(space)
    end
  end
end
