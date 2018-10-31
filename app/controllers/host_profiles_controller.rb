class HostProfilesController < OwnerSettingController
  def index
    @host_profile = HostProfile.find_by(user_id: current_user.id) || HostProfile.new(user_id: current_user.id)
  end

  def create
    @host_profile = HostProfile.new(host_profile_params)
    if @host_profile.save
      redirect_to space_settings_host_addresses_path(params[:space_id])
    else
      render :index
    end
  end

  def update
    @host_profile = HostProfile.find(params[:id])
    binding.pry
    if @host_profile.user_id == current_user.id
      if @host_profile.update(host_profile_params)
        redirect_to space_settings_host_addresses_path(params[:space_id])
      else
      render :index
      end
    else
      redirect_to root_path
    end
  end

  private
    def host_profile_params
      params.require(:host_profile).permit(
        :last_name,
        :first_name,
        :last_name_kata,
        :first_name_kata,
        :sex,
        :born_year,
        :born_manth,
        :born_day,
        :avatar,
        :phone_number,
        :identification,
        :company,
        :company_name,
        :company_name_kata,
        :company_name_en,
        :company_number
      ).merge(user_id: current_user.id)
    end

end
