# frozen_string_literal: true

module Admin
  class MoneyFlow < ::MoneyFlow
    belongs_to :admin_user, foreign_key: 'admin_user_id'
    has_many :money_flow_details, dependent: :destroy

    accepts_nested_attributes_for :money_flow_details, reject_if: :all_blank, allow_destroy: true
    validates_associated :money_flow_details

    delegate :name, to: :admin_user, prefix: true, allow_nil: true

    validates :title, presence: true
    validates :order_id, allow_blank: true, numericality: { allow_nil: true }

    scope :admin_user_id_eq, lambda { |v|
      where(admin_user_id: v) if v.present?
    }

    scope :money_flow_category_eq, lambda { |v|
      where(money_flow_category: v) if v.present?
    }
  end
end
