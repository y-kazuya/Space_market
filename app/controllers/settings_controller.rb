class SettingsController < ApplicationController
  before_action :set_host_profile
  def host_profile
  end

  def host_profile_update
    if params[:host_profile]
      unless @host_profile.update(host_profile_params)
      return render :host_profile
      end
    end
    redirect_to host_profile_user_settings_path(current_user.id)
  end

  def host_address
    @host_address = @host_profile.host_address
    if @host_profile.company == true
      @company_address = CompanyAddress.find_by(host_profile_id: @host_profile.id) || CompanyAddress.new(host_profile_id: @host_profile.id)
    end
  end

  def host_address_update
    if params[:host_address]
      @host_address = @host_profile.host_address
      unless @host_address.update(host_address_params)
       return render :host_address
      end
    end

    if params[:company_address]
      @company_address = @host_profile.company_address || CompanyAddress.new(host_profile_id: @host_profile.id)
      unless @company_address.update(company_address_params)
        return render :host_address
      end
    end
    redirect_to host_address_user_settings_path(current_user.id)
  end

  def host_bank
    @host_bank = @host_profile.host_bank
  end

  def host_bank_update
    if params[:host_bank]
      @host_bank = @host_profile.host_bank
      unless @host_bank.update(host_bank_params)
      return render :host_bank
      end
    end
    redirect_to host_bank_user_settings_path(current_user.id)
  end

  def calender
  end


  private
    def set_host_profile
      redirect_to root_path unless @host_profile = current_user.host_profile
    end

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
        :profile,
        :phone_number,
        :identification,
        :company,
        :company_name,
        :company_name_kata,
        :company_name_en,
        :company_number
      )
    end

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
      )
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

    def host_bank_params
      params.require(:host_bank).permit(
        :bank_name,
        :bank_code,
        :branch_name,
        :branch_code,
        :account_number,
        :account_name,
      )
    end

end
