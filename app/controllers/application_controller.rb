class ApplicationController < ActionController::Base
  include Internationalization
  include Pagy::Backend
  include ActionController::Caching
end
