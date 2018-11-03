class HostNotification < ApplicationRecord
  belongs_to :host_profile

  validates :about_mail_1,
            :about_mail_2,
            :about_mail_3,
            :about_mail_4,
            :about_mail_5,
            :about_mail_6,
            :about_call_1,
            :about_call_2,
            :about_call_3,
            inclusion: { in: [true, false] }
end
