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
end
