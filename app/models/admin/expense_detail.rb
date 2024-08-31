module Admin
  class ExpenseDetail < ::ExpenseDetail
    belongs_to :expense_category, foreign_key: 'expense_category_id'

    delegate :title, to: :expense_category, prefix: true, allow_nil: true

    validates :expense_category_id, presence: true

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end


  end
end
