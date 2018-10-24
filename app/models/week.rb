class Week < ApplicationRecord
 belongs_to :plan, optional: true


 validates :can, inclusion: { in: [true, false] }

 validates :start_time, numericality: { only_integer: true, less_than_or_equal_to: 36 }, allow_nil: true
 validates :start_time, presence: true, if: :day_can?

 validates :end_time, numericality: { only_integer: true, less_than_or_equal_to: 36 }, allow_nil: true
 validates :end_time, presence: true, if: :day_can?

 validate :check_time
 private
   def day_can?
     can == true
   end

   def check_time
     errors.add(:end, “開始時間より後にしてください“) if start_time >= end_time
   end

end
