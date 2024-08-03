class CookiesController < ApplicationController
  def index
    session[:cookies_accepted] = params[:cookies_accepted].presence
    #render turbo_stream: turbo_stream.remove(:cookie_consent)
  end

  def policy
  end
end
