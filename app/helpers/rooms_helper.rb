module RoomsHelper

  def day_low_high(room) #そのルームがもつプランの中(日がし)で一番安い〜一番高いプランを帰る
    if room.plans.count == 1
      return "#{room.plans.first.day_price}"
    else
      return "¥#{room.day_low_price} ~ ¥#{room.day_high_price}"
    end
  end

  def time_low_high(room) #そのルームがもつプランの中(時間がし)で一番安い〜一番高いプランを帰る
    if room.plans.count == 1
      return "#{room.plans.first.time_price}"
    else
      return "¥#{room.time_low_price} ~ ¥#{room.time_high_price}"
    end
  end
end
