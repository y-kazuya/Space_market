class EventsController < ApplicationController

  def index

    t = Time.new
    plan = Plan.find(params[:plan_id].to_i)
    room = Room.find(params[:room_id].to_i)

    case room.basic_info.reserve_period
    when "三ヶ月先" then
      set_sime = 3
    when "六ヶ月先" then
      set_sime = 6
    when "九ヶ月先" then
      set_sime = 9
    when "十二ヶ月先" then
      set_sime = 12
    else
      set_sime = 0
    end

    year = t.year
    sime = t.since(set_sime.month).strftime("20%y-%m-%d")
    today = t.strftime("20%y-%m-%d")

    @dates = (Date.parse(today)..Date.parse(sime)) ###当日から予約締め切り日まで

    @reserves = Reserve.where(room_id: params[:room_id].to_i)
    reserve_days = []
    @reserves.each do |re|
      re.reserve_dates.each do |day|
        reserve_days << day.start_date
      end
    end

    cant_weeks = plan.weeks.map{|w|w.name if w.can == false }.compact
    wd = ["祝日", "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]




    if params[:day].to_i == 0 ##つまり時間貸しで予約しようとした場合
      @can_re = []
      @can_re << {start: t, title: "実感がい", class_name: "can_reserve"}
    else ##日がしの場合

      @can_re =[]

      @dates.each do |day|
        title = "¥#{plan.day_price}~"
        class_name = "can_reserve"
        if reserve_days.include?(day.strftime("20%y-%m-%d")) ##予約被り
          class_name = "cant_reserve"
          title = "予約あり"
        end

        if cant_weeks.include?(wd[day.strftime("%u").to_i])
          class_name = "cant_reserve"
          title = "不可"
        end



        @can_re << {start: day, class_name: class_name ,title: title  }
      end
    end


    #最終的に予約できる日を返す
    # title: planの値段
    # start: 予約できる日 20180011とか
    # render :json => @event
    #hashでやる

    respond_to do |format|
      format.json
    end


  end


  def plan
    @plan = Plan.find(params[:plan_id].to_i)
    respond_to do |format|
      format.json
    end
  end

end
