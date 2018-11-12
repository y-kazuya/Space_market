class EditPlansController < RoomEditsController
  def index
    @room = Room.find(params[:room_id])
    @plans = @room.plans
  end

  def show
    @plan = Plan.find(params[:id])
    @room = @plan.room

  end

  def new
    @room = Room.find(params[:room_id])
    @week = %W[日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日 祝日]
    @plan = Plan.new(room_id: @room.id)
    @plan.weeks.build
  end

  def create
    @plan = Plan.new(plan_params)

    return redirect_to :back unless params[:plan2][:how_price]

    if params[:plan2][:how_type] == "日"
      @plan.day_pay = true
      @plan.time_pay = false
      @plan.day_price = params[:plan2][:how_price].to_i
    else
      @plan.day_pay = false
      @plan.time_pay = true
      @plan.time_price= params[:plan2][:how_price].to_i
    end


    unless @plan.save
      @week = %W[日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日 祝日]
      @room = Room.find(params[:room_id])
      return render :new
    end
    redirect_to user_room_plans_path(current_user.id, params[:room_id])
  end

  def update
    @plan = Plan.find(params[:id])
    @room = Room.find(params[:room_id])
    if @plan.room.space.user.id == current_user.id
      if @plan.update(plan_update_params)
        return redirect_to user_room_plans_path(current_user.id, @plan.room.id)
      else
        @room = Room.find(params[:room_id])
        return render :show
      end
    else
      redirect_to root_path
    end
  end


  def destroy
    plan = Plan.find(params[:id])
    unless plan.room.plans.count == 1
      if plan.room.space.user_id == current_user.id
        plan.destroy
      else
        return redirect_to root_path
      end
    end
    redirect_to user_room_plans_path(current_user.id, params[:room_id])
  end

  def public
    plan = Plan.find(params[:id])
    if plan.room.space.user_id == current_user.id
      plan.public == true ? plan.update(public: false) : plan.update(public: true)
      redirect_to user_room_plans_path(current_user.id, params[:room_id])
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
      :end_day,
      :start_day,
      :clean_time,
      :min_time,
      :public,
      :cost,
      :discount,
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
      :end_day,
      :start_day,
      :clean_time,
      :min_time,
      :public,
      :cost,
      :discount,
      weeks_attributes: [:name, :start_time, :end_time, :can, :id]
    )
  end
end
