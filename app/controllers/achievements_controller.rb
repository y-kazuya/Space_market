class AchievementsController < ApplicationController
  def summary
    @spaces = current_user.active_spaces
  end

  def ranking
    @spaces = current_user.active_spaces
  end

  def reputation
    @spaces = current_user.active_spaces
  end

  def sales
    @spaces = current_user.active_spaces
  end

end
