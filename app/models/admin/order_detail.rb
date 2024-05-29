module Admin
  class OrderDetail < ::OrderDetail
    belongs_to :service, foreign_key: 'service_id'

    delegate :title, to: :service, prefix: true, allow_nil: true

    validates :service_id, presence: true

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end


  end
end
