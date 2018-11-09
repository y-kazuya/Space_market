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

    if @reserve.valid?
      total = 0
      total = @reserve.plan.cost if @reserve.plan.cost

      unless @reserve.options == []
        @reserve.options.each do |op|
          total += op.price
        end
      end

      total += @reserve.reserve_dates.length * @reserve.plan.day_price
      binding.pry
      total -= params[:nebiki].to_i if params[:nebiki]
      @reserve.price = total
    end

      @reserve.save

    redirect_to space_room_reservations_path(@room.space.id, @room.id)
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
