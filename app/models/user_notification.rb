class UserNotification < ApplicationRecord
  belongs_to :user

  validates :about_mail_1,
            :about_mail_2,
            :about_mail_3,
            :about_mail_4,
            :about_mail_5,
            :about_call_1,
            :about_call_2,
            :about_call_3,
            :about_call_4,
            inclusion: { in: [true, false] }
end
