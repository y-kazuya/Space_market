class UserSettingController < ApplicationController
  before_action :loged_in?
  layout "user_setting"


  private
    def loged_in?
      redirect_to root_path unless current_user
    end
end
