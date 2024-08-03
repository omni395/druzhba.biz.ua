class CookiesController < ApplicationController
  def index
    session[:cookie_consent] = params[:cookie_consent].presence
    render turbo_stream: turbo_stream.remove(:cookie_consent)
  end

  def policy
  end
end
