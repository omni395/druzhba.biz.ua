# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  has_many :expenses
end
