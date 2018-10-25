class Plan < ApplicationRecord
 belongs_to :room
 has_many :weeks ,dependent: :destroy

 accepts_nested_attributes_for :weeks

 validates :name, presence: true, length: { maximum: 64 }
 validates :about, length: { maximum: 500 }

 validates :day_pay, inclusion: { in: [true, false] }

 validates :day_price, numericality: true, length: { maximum: 10 }, allow_nil: true
 validates :day_price, presence: true, if: :need_day?

 validates :time_pay, inclusion: { in: [true, false] }

 validates :time_price, numericality: true, length: { maximum: 10 }, allow_nil: true
 validates :time_price, presence: true, if: :need_time?

 validates :about_reserve, inclusion: { in: [true, false] }
 validate :need_pay

 validate :need_week


 def can_days
   weeks.map{|day| day if day.can == true}.compact!
 end


 private
   def need_pay
     if day_pay == false && time_pay == false
       errors.add(:time_pay, “どちらかは選択してください“)
     end
   end

   def need_day?
     day_pay == true
   end

   def need_time?
     time_pay == true
   end

   def need_week
     weeks.each do |week|
       return if week.can == true
     end
     errors.add(:weeks, “どれかは選択してください“)
   end
end