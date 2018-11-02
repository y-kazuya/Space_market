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

  def search
  #   @summary = []
  #   if params[:area]
  #     @summary << SpaceInfo.where[state:area]
  # end
end
