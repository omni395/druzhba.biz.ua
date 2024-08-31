class MandatoryExpense < ApplicationRecord
  belongs_to :expense_category
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :effective_from, presence: true
  validate :effective_to_after_effective_from
  
  scope :current, -> { where('effective_from <= ? AND (effective_to IS NULL OR effective_to >= ?)', Date.current, Date.current) }
  
  private
  
  def effective_to_after_effective_from
    return if effective_to.blank? || effective_from.blank?
    
    if effective_to < effective_from
      errors.add(:effective_to, "должна быть позже, чем дата начала действия")
    end
  end
end
