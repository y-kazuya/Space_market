class AgreementsController < ApplicationController
  def show
    @room = Room.find(params[:room_id])
    @agree = Agreement.find_by(room_id: @room.id) || Agreement.new(room_id: @room_id)
  end

  def create
    @agree = Agreement.new(agree_params)
    unless @agree.save
      @room = Room.find(params[:room_id])
      render :show
    end
   redirect_to user_room_agreements_path(current_user.id, params[:room_id])
  end

  def update
    @room = Room.find(params[:room_id])
    @agree = Agreement.find(@room.agreement.id)
    unless @agree.update(agree_params)
      return render :show
    end
   redirect_to user_room_agreements_path(current_user.id, params[:room_id])

  end


  private
    def agree_params
      params.require(:agreement).permit(
        :aggree,
        :policy
      ).merge(room_id: params[:room_id].to_i)
    end
end
