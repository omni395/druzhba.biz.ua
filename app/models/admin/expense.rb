module Admin
  class Expense < ::Expense
    belongs_to :admin_user, foreign_key: 'admin_user_id'
    belongs_to :expense_category, foreign_key: 'expense_category_id'

    delegate :name, to: :admin_user, prefix: true, allow_nil: true
    delegate :title, to: :expense_category, prefix: true, allow_nil: true

    validates :title, presence: true
    validates :order_id, allow_blank: true, numericality: { allow_nil: true }

    scope :admin_user_id_eq, ->(v) do
      where(admin_user_id: v) if v.present?
    end

    scope :expense_category_id_eq, ->(v) do
      where(expense_category_id: v) if v.present?
    end


  end
end
