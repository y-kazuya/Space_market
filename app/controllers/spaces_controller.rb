class SpacesController < ApplicationController
  def new
    # redirect_to space_dashboard_path(current_user.spaces.first.id) unless current_user.spaces.empty?
    # space = Space.new(user_id: current_user.id)

    # if space.save
    #   redirect_to new_space_room_path(space)
    # end
  end

  def new_first
    unless space = Space.find_by(user_id: current_user.id)
      space = Space.new(user_id: current_user.id)
      space.save
    end
    redirect_to new_space_room_path(space)
  end
end
