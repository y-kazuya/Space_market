class SearchController < ApplicationController


  def event_type
    usage = Usage.find(params[:id])
    basic_infos_usages = usage.basic_info_usages

    @searchRooms = []
    basic_infos_usages.each do |basic_infos_usage|
      rooms = BasicInfo.find(basic_infos_usage.basic_info_id)
      @searchRooms << rooms.room
    end
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
        @capa = params[:state][:capacity]
        @oo = []

        results.each do |room|
            @oo << room if room.basic_info.capacity >= params[:state][:capacity].to_i
          end
      results = @oo
      end
    end
    @results = results
  end
end
