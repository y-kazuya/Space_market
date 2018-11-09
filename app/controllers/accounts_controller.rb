class AccountsController < UserSettingController

  def show
    @user = current_user
  end

  def update
    @user = current_user
    unless @user.update(user_params)
      return render :show
    end
    redirect_to account_path
  end


  private
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :avatar,
        :profile,
        :email
      )
    end
end
