class ReservationsController < ApplicationController

  def show
    @room = Room.find(params[:room_id])
    @reserve = Reserve.new()
    @reserve.reserve_options.build
    @reserve.reserve_dates.build
  end



  def create
    @room = Room.find(params[:room_id])
    @reserve = Reserve.new(reserve_params)
    @reserve.day = 1

    if params[:nebiki]
      return redirect_to space_room_reservations_path(@room.space.id, @room.id) if params[:nebiki].to_i > current_user.point
    end



    if @reserve.valid?
      total = 0
      total = @reserve.plan.cost if @reserve.plan.cost

      unless @reserve.options == []
        @reserve.options.each do |op|
          total += op.price
        end
      end

      total += @reserve.reserve_dates.length * @reserve.plan.day_price
      if params[:nebiki]
        total -= params[:nebiki].to_i
        point = current_user.point
        point += total / 100
        point -= params[:nebiki].to_i
        current_user.update(point: point)
      end
      @reserve.price = total

    end


    return redirect_to result_reservation_path(@reserve.id) if @reserve.save

    redirect_to space_room_reservations_path(@room.space.id, @room.id)
  end

  def destroy
    re = Reserve.find(params[:id])
    room = re.room
    sp = room.space
    if re.user.id == current_user.id
      re.destroy
      redirect_to space_room_reservations_path(sp.id, room.id)

    else
      redirect_to root_path
    end

  end


  def result
    @reserve = Reserve.find(params[:id])

  end


  private
    def reserve_params
      params.require(:reserve).permit(
        :day,
        :company,
        :payment,
        :purpose,
        :people,
        :usage,
        :coupon,
        :plan_id,
        :card_id,
        { :option_ids => [] },
        reserve_dates_attributes: [:start_date, :day,:start_time, :end_time]
      ).merge(room_id: params[:room_id].to_i, user_id: current_user.id,)
    end

  #  reserve_dates_attributes: [:start_date, :day,:start_time, :end_time]
end
