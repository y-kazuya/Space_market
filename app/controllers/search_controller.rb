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
    results = Room.joins(basic_info: [:basic_info_usages]).where("usage_id = ?", "#{params[:event_type].to_i}").distinct.where(activated: "certification").where(rooms: {public: true })

    @event_type = params[:event_type].to_i


    if params[:state]

      if results.length >= 1 && params[:state][:name] != ""
        @ken = params[:state][:name].to_s
        yoko = []
        results.each do |room|
          yoko << room if room.space.space_info.state == params[:state][:name]
        end

        results = yoko
      end

      if results.length >= 1 && params[:state][:price] != ""
        @price = params[:state][:price].to_i
        @kane = []

        results.each do |room|
          room.public_plans.each do |plan|

            @kane << room if plan.day_price <= params[:state][:price].to_i
              break
          end
        end
        results = @kane
      end


      if results.length >= 1 && params[:state][:capacity] != ""

        @oo = []

        results.each do |room|
            @oo << room if room.basic_info.capacity >= params[:state][:capacity].to_i
          end
      results = @oo
      end
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


