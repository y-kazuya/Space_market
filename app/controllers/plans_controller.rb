class PlansController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @room = Room.find(params[:room_id])
    if Plan.find_by(room_id: @room.id)
      @plan = Plan.find_by(room_id: @room.id)

    else
      @plan = Plan.new(room_id: @room.id)
      @plan.weeks.build
    end
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.room.space.user.id == current_user.id
      binding.pry
      if @plan.save
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.room.space.user.id == current_user.id
      if @plan.update(plan_update_params)
        redirect_to root_path
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
        weeks_attributes: [:name, :start, :end, :can]
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
        weeks_attributes: [:name, :start, :end, :can, :id]
      ).merge(room_id: params[:room_id].to_i)
    end
    # params.permit(items: [:name, :price])[:items]
end
