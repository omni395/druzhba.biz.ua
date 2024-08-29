# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    before_action { @page_title = 'Головна' }

    def index; end
  end
end
