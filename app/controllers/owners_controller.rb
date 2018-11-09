class OwnersController < ApplicationController

  def show
    @host = HostProfile.find(params[:id])
    @spaces = @host.user.public_spaces
    redirect_to root_path if @host.user.owner == 0
  end
end
