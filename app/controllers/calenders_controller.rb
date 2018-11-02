class CalendersController < ApplicationController
  def show
    @spaces = current_user.active_spaces
  end
end
