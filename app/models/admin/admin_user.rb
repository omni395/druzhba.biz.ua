module Admin
  class AdminUser < ::AdminUser
    include DatetimeFieldConcern

    datetime_field :reset_password_sent_at
    datetime_field :remember_created_at

    validates :email, presence: true
    validates :password, presence: true

    validates :reset_password_sent_at_date, presence: true, if: -> { reset_password_sent_at_time.present? }
    validates :reset_password_sent_at_time, presence: true, if: -> { reset_password_sent_at_date.present? }
    validates :remember_created_at_date, presence: true, if: -> { remember_created_at_time.present? }
    validates :remember_created_at_time, presence: true, if: -> { remember_created_at_date.present? }

    scope :email_eq, ->(v) do
      where(email: v) if v.present?
    end


  end
end
