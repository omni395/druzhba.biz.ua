module Admin
  class MoneyFlowDetail < ::MoneyFlowDetail
    belongs_to :money_flow_category, foreign_key: 'money_flow_category_id'

    delegate :title, to: :money_flow_category, prefix: true, allow_nil: true

    validates :money_flow_category_id, presence: true

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end


  end
end
