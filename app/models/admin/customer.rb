# frozen_string_literal: true

module Admin
  class Customer < ::Customer
    has_many :orders, dependent: :destroy

    validates :name, presence: true
    validates :phone, presence: true, uniqueness: true

    scope :name_full_like, lambda { |v|
      where(arel_table[:name].matches("%#{v}%")) if v.present?
    }

    scope :phone_full_like, lambda { |v|
      where(arel_table[:phone].matches("%#{v}%")) if v.present?
    }
  end
end
