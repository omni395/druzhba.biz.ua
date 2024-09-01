# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  has_many :expenses

  scope :mandatory, -> { where(mandatory: true) }
  scope :optional, -> { where(mandatory: false) }
end
