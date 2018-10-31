class AdminsController < ApplicationController


  def show
    @admins = []
    current_user.spaces.each do |space|
      space.admins.each do |admin|
        @admins << admin
      end
    end
  end

  def create
    if admin = User.find_by(email: params[:email])
      Admin.create!(user_id: admin.id, space_id: current_user.spaces.first.id)
    else
      return render :show
    end
    redirect_to user_admin_path(current_user.id)
  end

  def destroy
    if @admin = Admin.find(params[:admin_id].to_i)
      if @admin.space.user_id = current_user.id
        @admin.destroy
      else
        redirect_to root_path
      end
    end
    redirect_to user_admin_path(current_user.id)
  end


end
