class ApplicationController < ActionController::Base
  include Internationalization
  include Pagy::Backend
end
