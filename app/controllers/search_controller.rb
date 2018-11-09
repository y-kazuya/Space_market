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
    max_price = params[:max_price][:price]
    max_capacity = params[:max_capacity][:capacity]
    # 検索結果格納
    @results = []
    @rooms = []
    # 認証済であり、公開されている部屋を絞る。さらにエリアで絞り込む
    if params[:state][:name]
      @rooms = Room.joins(space: [:space_info]).where("state = ?", "#{state_id}" ).distinct.where(activated: "certification").where(rooms: {public: true })
    end
    unless @rooms.length == 0
       #さらに金額で絞り込む
      @rooms.each do |room|
        room.plans.each do |plan|
          if plan.day_price <= max_price.to_i
            #さらに人数で絞り込む
            if room.basic_info.capacity >= max_capacity.to_i
              @results << room
              break
            end
          end
        end
      end
    end
    render :index, layout: false
  end
end


