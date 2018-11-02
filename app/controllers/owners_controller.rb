class OwnersController < ApplicationController

  def show
    @host = HostProfile.find(params[:id])
    @spaces = @host.user.spaces
  end
end
