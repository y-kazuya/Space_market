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
      redirect_to root_path
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
        redirect_to root_path
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
