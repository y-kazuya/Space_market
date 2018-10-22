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
    binding.pry

    if @plan.save
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
        weeks_attributes: [:name, :start, :end]
      ).merge(room_id: params[:room_id].to_i)
    end
end
