class ReservePhrasesController < ApplicationController
  def show
    @room = Room.find(params[:room_id])
    @res = ReservePhrase.find_by(room_id: @room.id) || ReservePhrase.new(room_id: @room_id)
  end

  def create
    binding.pry
    @res = ReservePhrase.new(res_params)
    unless @res.save
      @room = ReservePhrase.find(params[:room_id])
      render :show
    end
   redirect_to user_room_reserve_phrases_path(current_user.id, params[:room_id])
  end

  def update
    @room = Room.find(params[:room_id])
    @res = ReservePhrase.find(@room.agreement.id)
    unless @res.update(res_params)
      return render :show
    end
   redirect_to user_room_reserve_phrases_path(current_user.id, params[:room_id])

  end


  private
    def res_params
      params.require(:reserve_phrase).permit(
        :success,
        :fail,
        :remind
      ).merge(room_id: params[:room_id].to_i)
    end
end
