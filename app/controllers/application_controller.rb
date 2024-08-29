# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Internationalization
  include Pagy::Backend
  include ActionController::Caching
end
