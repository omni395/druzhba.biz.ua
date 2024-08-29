# frozen_string_literal: true

class MoneyFlowDetail < ApplicationRecord
  belongs_to :money_flow
  belongs_to :money_flow_category
end
