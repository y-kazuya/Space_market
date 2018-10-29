class PagesController < ApplicationController
  before_action :login?, only: [:host_entry]

  def top
  end

  def host_entry
    space = Space.find_by(user_id: current_user.id)
    if space && Room.find_by(space_id: space.id)
      redirect_to  space_dashboard_path(current_user.spaces.first.id)

    elsif space
      redirect_to new_space_room_path(current_user.spaces.first.id)
    end

  end


  private
    def login?
      redirect_to :top unless current_user
    end
end
