module Admin
  class LandingMessage < ::LandingMessage
    validates :name, presence: true, length: { maximum: 50, minimum: 3 }
    validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { minimum: 5, maximum: 255 }
    validates :message, presence: true, length: { maximum: 1000, minimum: 10 }

    PHONE_NUMBER_REGEX = /\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{2}(\s|-)?\d{2}/
    validates :phone, presence: true
    validates :phone, format: { with: PHONE_NUMBER_REGEX, message: I18n.t('global.errors.phone_format') }
    validates :phone, length: { in: 10..15 }
  
    enum status: { new: 0, in_work: 1, done: 2, rejected: 3 }, _prefix: true


    scope :name_full_like, ->(v) do
      where(arel_table[:name].matches("%#{v}%")) if v.present?
    end

    scope :email_full_like, ->(v) do
      where(arel_table[:email].matches("%#{v}%")) if v.present?
    end

    scope :status_any, ->(v) do
      where(status: v) if v.present?
    end


  end
end
