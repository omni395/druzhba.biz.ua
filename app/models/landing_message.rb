# frozen_string_literal: true

class LandingMessage < ApplicationRecord
  include FormattedField

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  validates :name, length: { minimum: 3 }

  PHONE_NUMBER_REGEX = /\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{2}(\s|-)?\d{2}/
  validates :phone, presence: true
  validates :phone, format: { with: PHONE_NUMBER_REGEX, message: I18n.t('global.errors.phone_format') }
  validates :phone, length: { in: 10..15 }

  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, length: { minimum: 5 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :message, presence: true
  validates :message, length: { maximum: 1000 }
  validates :message, length: { minimum: 1 }

  enum status: { new: 0, in_work: 1, done: 2, rejected: 3 }, _prefix: true

  def valid_phone_number?(phone)
    phone.match?(/\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{2}(\s|-)?\d{2}/)
  end
end
