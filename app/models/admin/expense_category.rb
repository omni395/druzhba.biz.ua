module Admin
  class ExpenseCategory < ::ExpenseCategory
    has_many :expenses, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true

    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end


  end
end
