module Admin
  class ExpenseCategory < ::ExpenseCategory
    has_many :expense, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true
    validates :flow, presence: true

    enum flow: { income: 0, outcome: 1 }, _prefix: true


    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end

    scope :flow_any, ->(v) do
      where(flow: v) if v.present?
    end


  end
end
