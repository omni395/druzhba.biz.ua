module Admin
  class Order < ::Order
    include DatetimeFieldConcern

    belongs_to :customer, foreign_key: 'customer_id'
    belongs_to :admin_user, foreign_key: 'admin_user_id'
    has_many :order_details, dependent: :destroy

    accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
    validates_associated :order_details

    delegate :name, to: :customer, prefix: true, allow_nil: true
    delegate :name, to: :admin_user, prefix: true, allow_nil: true

    validates :status, presence: true
    validates :paid, presence: true
    validates :price, presence: true

    enum status: { new: 0, in_work: 1, done: 2, rejected: 3 }, _prefix: true
    enum paid: { unpaid: 0, inpaid: 1 }, _prefix: true


    scope :customer_id_eq, ->(v) do
      where(customer_id: v) if v.present?
    end

    scope :status_any, ->(v) do
      where(status: v) if v.present?
    end

    scope :paid_any, ->(v) do
      where(paid: v) if v.present?
    end

    scope :admin_user_id_eq, ->(v) do
      where(admin_user_id: v) if v.present?
    end


  end
end
