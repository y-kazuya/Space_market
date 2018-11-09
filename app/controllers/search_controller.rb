class SearchController < ApplicationController
  def event_type
    usage = Usage.find(params[:id])
    basic_infos_usages = usage.basic_info_usages

    @searchRooms = []
    basic_infos_usages.each do |basic_infos_usage|
      rooms = BasicInfo.find(basic_infos_usage.basic_info_id)
      @searchRooms << rooms.room
    end
    render :event_type, layout: false
  end

  def index
    state_name = params[:state][:name]
    state_id = SpaceInfo.states[state_name.to_s]

    params[:max_price][:price] != "" ?  max_price = params[:max_price][:price].to_i : max_price = 1000000000000000000000000000
    params[:max_capacity][:capacity] != "" ? max_capacity = params[:max_capacity][:capacity].to_i : max_capacity = 0
    # max_price = params[:max_price][:price].to_i
    # max_capacity = params[:max_capacity][:capacity].to_i
    # 検索結果格納



    @rooms = []
    # 認証済であり、公開されている部屋を絞る。さらにエリアで絞り込む
    if params[:state][:name]
      results = Room.joins(space: [:space_info]).where("state = ?", "#{state_id}" ).distinct.where(activated: "certification").where(rooms: {public: true })

    end


    if results.length >= 1

      @kane = []

      results.each do |room|
        room.public_plans.each do |plan|

          @kane << room if plan.day_price <= max_price
            break
        end
      end
      results = @kane
    end


    if results.length >= 1
      @oo = []

      results.each do |room|
          @oo << room if room.basic_info.capacity >= max_capacity
        end
     results = @oo
    end


    @results = results

    # if @rooms.length >= 1
    #    #さらに金額で絞り込む
    #   @rooms.each do |room|
    #     room.public_plans.each do |plan|
    #       if plan.day_price <= max_price
    #         #さらに人数で絞り込む
    #         if room.basic_info.capacity >= max_capacity
    #           @results << room
    #           break
    #         end
    #       end
    #     end
    #   end
    # end
    render :index, layout: false
  end
end


