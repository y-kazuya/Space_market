class DashboardsController < ApplicationController
  before_action :owner?, only: :show
  before_action :set_spaces, only: :show
  layout "room_new"
  # , only: :show

  def first_space
    @space = current_user.spaces.first
    @room = @space.rooms.first
    return redirect_to new_space_room_path(@space.id) unless @space && @room
    redirect_to root_path if @space == nil && @room == nil
  end

  def show
  end


  private
    def owner?
      redirect_to root_path if current_user.owner == false || current_user.id != params[:user_id].to_i
    end

    def set_spaces
      @spaces = current_user.active_spaces
    end

end
