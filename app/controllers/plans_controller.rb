class PlansController < RoomInfosController
  def new
    @week = %W[日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日 祝日]
    if Plan.find_by(room_id: @room.id)
      @plan = Plan.find_by(room_id: @room.id)
    else
      @plan = Plan.new(room_id: @room.id)
      @plan.weeks.build
    end
  end

  def create

    @plan = Plan.new(plan_params)

    if @plan.save

      if current_user.owner == true
        return redirect_to stats_user_room_path(current_user.id, @plan.room.id)
      else
        return redirect_to space_dashboard_path(params[:space_id])
      end
    else
      @room = @plan.room
      @space = @room.space
      render :new
    end
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.room.space.user.id == current_user.id
      if @plan.update(plan_update_params)
        if current_user.owner == true
          return redirect_to stats_user_room_path(current_user.id, @plan.room.id)
         else
          return redirect_to space_dashboard_path(params[:space_id])
         end
      else
        @room = @plan.room
        @space = @room.space
        render :new
      end
    else
      redirect_to root_path
    end
  end

  private
    def plan_params
      params.require(:plan).permit(
        :name,
        :about,
        :time_pay,
        :time_price,
        :day_pay,
        :day_price,
        :about_reserve,
        weeks_attributes: [:name, :start_time, :end_time, :can]
      ).merge(room_id: params[:room_id].to_i)
    end

    def plan_update_params
      params.require(:plan).permit(
        :name,
        :about,
        :time_pay,
        :time_price,
        :day_pay,
        :day_price,
        :about_reserve,
        weeks_attributes: [:name, :start_time, :end_time, :can, :id]
      ).merge(room_id: params[:room_id].to_i)
    end
    # params.permit(items: [:name, :price])[:items]
end
