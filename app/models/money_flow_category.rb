# frozen_string_literal: true

class MoneyFlowCategory < ApplicationRecord
  has_many :money_flow_detail
end
