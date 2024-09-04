# frozen_string_literal: true

module Admin
  class ExpenseCategory < ::ExpenseCategory
    has_many :expense, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true

    scope :id_eq, lambda { |v|
      where(id: v) if v.present?
    }
  end
end
