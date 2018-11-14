class ReservationsController < ApplicationController

  def show
    return redirect_to new_payments_path if current_user.cards ==[]
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
      point = current_user.point
      point += total / 100
      if params[:nebiki]
        use_point = params[:nebiki].to_i
        total -= params[:nebiki].to_i
        point -= params[:nebiki].to_i
      end
      current_user.update(point: point)
      @reserve.price = total

    end


    return redirect_to result_reservation_path(@reserve.id, use_point: use_point) if @reserve.save

    redirect_to space_room_reservations_path(@room.space.id, @room.id)
  end

  def destroy
    re = Reserve.find(params[:id])
    room = re.room
    sp = room.space
    if re.user.id == current_user.id
      point = current_user.point
      point += params[:point].to_i
      point -= re.price / 100

      current_user.update(point: point)
      re.destroy

      redirect_to space_room_reservations_path(sp.id, room.id)

    else
      redirect_to root_path
    end

  end


  def result
    @reserve = Reserve.find(params[:id])
    @use_point = params[:use_point].to_i || 0
  end

  def confirm_reservation
    @reservations = nil?
    if Reserve.where(id:current_user.id) != nil?
      @reservations = Reserve.where(user_id:current_user.id)
    end
  end

  def destroy_reservation
    reserve = Reserve.find(params[:id])
    reserve.destroy
    redirect_to confirm_reservation_reservations_path
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
