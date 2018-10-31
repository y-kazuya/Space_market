class HostAddressesController < OwnerSettingController
  def index
    @host_address = HostAddress.find_by(host_profile_id: @host_profile.id) || HostAddress.new(host_profile_id: @host_profile.id)
    if @host_profile.company == true
      @company_address = CompanyAddress.find_by(host_profile_id: @host_profile.id) || CompanyAddress.new(host_profile_id: @host_profile.id)
    end

  end

  def create
    @host_address = HostAddress.new(host_address_params)
    if @host_profile.company == true
      @company_address = CompanyAddress.new(company_address_params)

      unless @company_address.save
        return render :index
      end
    end
    if @host_address.save
      redirect_to space_settings_host_banks_path(params[:space_id])
    else
      render :index
    end
  end

  def update
    @host_address = HostAddress.find(params[:id])
    if @host_profile.company == true
      @company_address = CompanyAddress.find_by(host_profile_id: @host_profile.id) || CompanyAddress.new(company_address_params)
      if @company_address.host_profile.user_id == current_user.id
        unless @company_address.update(company_address_params)
          return render :index
        end
      else
        redirect_to root_path
      end
    end
    if @host_address.host_profile.user_id == current_user.id
      if @host_address.update(host_address_params)
        redirect_to space_settings_host_banks_path(params[:space_id])
      else
      render :index
      end
    else
      redirect_to root_path
    end
  end

  private
    def host_address_params
      params.require(:host_address).permit(
        :post_code,
        :state,
        :city,
        :city_kata,
        :address,
        :last_address,
        :address_kata,
        :last_address_kata,
        :building,
        :building_kata,
      ).merge(host_profile_id: current_user.host_profile.id)
    end

    def company_address_params
      params.require(:company_address).permit(
        :post_code,
        :state,
        :city,
        :city_kata,
        :address,
        :last_address,
        :address_kata,
        :last_address_kata,
        :building,
        :building_kata,
      ).merge(host_profile_id: current_user.host_profile.id)
    end



end
