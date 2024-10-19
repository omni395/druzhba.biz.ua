# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Internationalization
  include Pagy::Backend
  include ActionController::Caching

  before_action :check_cookies

  def check_cookies
    @cookie_value = cookies[:allow_cookies]
  end
end
