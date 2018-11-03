class HostNotificationsController < SettingsController
  def show
    @notification = HostNotification.find_by(host_profile_id: @host_profile.id)
  end

  def update

    @noti = HostNotification.find(params[:id].to_i)
    if @noti.host_profile.user_id == current_user.id
      unless @noti.update(host_noti_params)
      render :show
      end
    else
      redirect_to root_path
    end
    redirect_to user_host_notification_path(current_user.id)
  end

  private

    def host_noti_params
      params.require(:host_notification).permit(
        :about_mail_1,
        :about_mail_2,
        :about_mail_3,
        :about_mail_4,
        :about_mail_5,
        :about_mail_6,
        :about_call_1,
        :about_call_2,
        :about_call_3
      ).merge(host_profile_id: current_user.host_profile.id)
    end
end
