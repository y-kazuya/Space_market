class OwnerSettingController < ApplicationController
  before_action :set_space_or_redirect
  before_action :set_host_prolie_or_redirect, unless: :host_profiles_controller?



  private

  def host_profiles_controller?
    params[:controller] == "host_profiles"
  end
  def set_host_prolie_or_redirect
    unless @host_profile = current_user.host_profile
      redirect_to space_settings_host_profiles_path(@space)
    end
  end

  def set_space_or_redirect
    unless @space = Space.find(params[:space_id])
      redirect_to new_first_spaces_path
    end
  end
end
