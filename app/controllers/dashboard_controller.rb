class DashboardController < ApplicationController

  def first_space
    @space = current_user.spaces.first
    @room = @space.rooms.first
  end
end
