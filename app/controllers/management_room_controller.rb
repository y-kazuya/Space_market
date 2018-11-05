class ManagementRoomController < ApplicationController
  before_action :owner?, expect: :first_space
  before_action :set_spaces, expect: :first_space




  private
    def owner?
      redirect_to root_path if current_user.owner == false || current_user.id != params[:user_id].to_i
    end

    def set_spaces
      @spaces = current_user.active_spaces
    end
end
