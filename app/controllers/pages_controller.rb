class PagesController < ApplicationController
  before_action :login?, only: [:host_entry]
  layout "all", only: :top

  def top

    @space_info = SpaceInfo.new

    # render "tmp/registration_menu_main"

  end

  def host_entry
    space = Space.find_by(user_id: current_user.id)
    if space && Room.find_by(space_id: space.id)
      return redirect_to  space_dashboard_path(current_user.spaces.first.id)

    elsif space
      return redirect_to new_space_room_path(current_user.spaces.first.id)
    end

    redirect_to new_first_spaces_path

  end


  private
    def login?
      redirect_to :top unless current_user
    end
end
