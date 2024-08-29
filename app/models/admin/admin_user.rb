# frozen_string_literal: true

module Admin
  class AdminUser < ::AdminUser
    include DatetimeFieldConcern

    datetime_field :reset_password_sent_at
    datetime_field :remember_created_at

    validates :email, presence: true
    validates :name, presence: true
    validates :password, presence: true

    validates :reset_password_sent_at_date, presence: true, if: -> { reset_password_sent_at_time.present? }
    validates :reset_password_sent_at_time, presence: true, if: -> { reset_password_sent_at_date.present? }
    validates :remember_created_at_date, presence: true, if: -> { remember_created_at_time.present? }
    validates :remember_created_at_time, presence: true, if: -> { remember_created_at_date.present? }

    enum role: { admin: 0, manager: 1 }, _prefix: true

    scope :email_eq, lambda { |v|
      where(email: v) if v.present?
    }

    scope :name_full_like, lambda { |v|
      where(arel_table[:name].matches("%#{v}%")) if v.present?
    }
  end
end
