class NotificationsController < UserSettingController
  def show
    @noti = current_user.user_notification
  end

  def update
    @noti = current_user.user_notification
    unless @noti.update(user_noti_params)
      return render :show
    end
    redirect_to notification_path
  end


  private
    def user_noti_params
      params.require(:user_notification).permit(
        :about_mail_1,
        :about_mail_2,
        :about_mail_3,
        :about_mail_4,
        :about_mail_5,
        :about_call_1,
        :about_call_2,
        :about_call_3,
        :about_call_4,
      )
    end
end
