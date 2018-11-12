module RoomsHelper

  def day_low_high(room) #そのルームがもつプランの中(日がし)で一番安い〜一番高いプランを帰る
    if room.public_plans.count == 1
      return "#{room.public_plans.first.day_price}"
    else
      return "¥#{room.day_low_price} ~ ¥#{room.day_high_price}"
    end
  end

  def time_low_high(room) #そのルームがもつプランの中(時間がし)で一番安い〜一番高いプランを帰る
    if room.public_plans.count == 1
      return "#{room.public_plans.first.time_price}"
    else
      return "¥#{room.time_low_price} ~ ¥#{room.time_high_price}"
    end
  end

  def favalite_room?(room)
    if current_user
      current_user.favorite_lists.each do |list|
        list.favorites.each do |f|
          return true if f.room_id == room.id
        end
      end
    end

    return false
  end


  def set_price(price, type)
    "¥#{price}/#{type}〜"
  end

  def set_plan_price(plan, count, k)
    if count == 2 && k == 1
      return "¥#{plan.time_price}/"
    elsif count == 2 && k == 2
      return "¥#{plan.day_price}/"
    else
      if plan.day_pay == true
        return "¥#{plan.day_price}/"
      else
        return "¥#{plan.time_price}/"
      end
    end
  end

  def set_plan_unit(plan,count, k)
    if count == 2 && k == 1
      return "時間"
    elsif count == 2 && k == 2
      return "日"
    else
      if plan.day_pay == true
        return "日"
      else
        return "時間"
      end
    end
  end

  def set_event_type_count(id)
    Room.joins(basic_info: [:basic_info_usages]).where("usage_id = ?", "#{id}").distinct.where(activated: "certification").where(rooms: {public: true }).count
  end
end
