# frozen_string_literal: true

module Admin
  class Expense < ::Expense
    belongs_to :admin_user, foreign_key: 'admin_user_id'
    belongs_to :expense_category, foreign_key: 'expense_category_id'

    delegate :name, to: :admin_user, prefix: true, allow_nil: true
    delegate :title, to: :expense_category, prefix: true, allow_nil: true

    validates :title, presence: true

    scope :admin_user_id_eq, lambda { |v|
      where(admin_user_id: v) if v.present?
    }

    scope :expense_category_id_eq, lambda { |v|
      where(expense_category_id: v) if v.present?
    }
  end
end
