# frozen_string_literal: true

class Customer < ApplicationRecord
  include FormattedField

  has_many :orders, class_name: 'orders', foreign_key: 'reference_id'

  PHONE_NUMBER_REGEX = /\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{2}(\s|-)?\d{2}/
  validates :phone, presence: true
  validates :phone, format: { with: PHONE_NUMBER_REGEX, message: I18n.t('global.errors.phone_format') }
  validates :phone, length: { in: 10..15 }

  def valid_phone_number?(phone)
    phone.match?(/\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{2}(\s|-)?\d{2}/)
  end
end
