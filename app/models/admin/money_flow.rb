module Admin
  class MoneyFlow < ::MoneyFlow
    belongs_to :admin_user, foreign_key: 'admin_user_id'
    belongs_to :money_flow_category, foreign_key: 'money_flow_category_id'
    has_many :money_flow_details, dependent: :destroy

    accepts_nested_attributes_for :money_flow_details, reject_if: :all_blank, allow_destroy: true
    validates_associated :money_flow_details

    delegate :name, to: :admin_user, prefix: true, allow_nil: true
    delegate :title, to: :money_flow_category, prefix: true, allow_nil: true

    validates :title, presence: true

    scope :admin_user_id_eq, ->(v) do
      where(admin_user_id: v) if v.present?
    end

    scope :money_flow_category_id_eq, ->(v) do
      where(money_flow_category_id: v) if v.present?
    end


  end
end
