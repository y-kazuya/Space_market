class SettingsController < ApplicationController
  before_action :set_host_profile
  def host_profile
  end

  def host_address
    @host_address = @host_profile.host_address
    @ccompany_address = @host_profile.company_address
  end

  def host_bank
    @host_bank = @host_profile.host_bank
  end

  def calender
  end

  def admin
  end

  def notification
  end



  private
    def set_host_profile
      redirect_to root_path unless @host_profile = current_user.host_profile
    end
end
