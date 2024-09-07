module Admin
  class Customer < ::Customer
    has_many :orders, dependent: :destroy

    validates :name, presence: true
    validates :phone, presence: true, uniqueness: true

    scope :name_full_like, ->(v) do
      where(arel_table[:name].matches("%#{v}%")) if v.present?
    end

    scope :phone_full_like, ->(v) do
      where(arel_table[:phone].matches("%#{v}%")) if v.present?
    end


  end
end
