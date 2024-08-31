# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  has_many :expenses

  enum flow: { income: 0, expense: 1 }
  
  scope :mandatory, -> { where(mandatory: true) }
  scope :optional, -> { where(mandatory: false) }
end
