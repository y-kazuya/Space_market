class DashboardsController < ManagementRoomController
  def first_space
    @space = current_user.spaces.first
    @room = @space.rooms.first
    redirect_to root_path if @space == nil && @room == nil
  end

  def show
  end

end
