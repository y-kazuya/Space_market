class DashboardsController < ApplicationController
  before_action :owner?, only: :show
  def first_space
    @space = current_user.spaces.first
    @room = @space.rooms.first
    redirect_to root_path if @space == nil && @room == nil
  end

  def show
    @spaces = current_user.active_spaces
  end

  private
    def owner? #ユーザーが認証済みの部屋を持ってないかつ 認証待ちの部屋を持っていない場合
      redirect_to root_path unless current_user.active_owner? || current_user.waiting_owner?
    end
end
