class HostBanksController < OwnerSettingController
  def index
    @host_bank = HostBank.find_by(host_profile_id: @host_profile.id) || HostBank.new(host_profile_id: @host_profile.id)
  end

  def create
    @host_bank = HostBank.new(host_bank_params)
    if @host_bank.save
      redirect_to space_dashboard_path(params[:space_id])
    else
      render :index
    end
  end

  def update
    @host_bank = HostBank.find(params[:id])
    if @host_bank.host_profile.user_id == current_user.id
      if @host_bank.update(host_bank_params)
        redirect_to space_dashboard_path(params[:space_id])
      else
      render :new
      end
    else
      redirect_to root_path
    end
  end

  private
    def host_bank_params
      params.require(:host_bank).permit(
        :bank_name,
        :bank_code,
        :branch_name,
        :branch_code,
        :account_number,
        :account_name,
      ).merge(host_profile_id: current_user.host_profile.id)
    end

end
