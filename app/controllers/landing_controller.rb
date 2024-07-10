class LandingController < ApplicationController
  def index
  end

  def prices
    @repair = Service.repair
    @sewing = Service.sewing
  end

  def about
  end

  def contacts
  end

  def faq
  end
end
