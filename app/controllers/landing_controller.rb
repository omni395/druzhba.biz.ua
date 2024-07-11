class LandingController < ApplicationController
  before_action { @page_title }

  def index
  end

  def prices
    @repair = Service.repair
    @sewing = Service.sewing
    @page_title = "Ціни"
  end

  def about
    @page_title = "Про нас"
  end

  def contacts
    @page_title = "Контакти"
  end

  def faq
    @page_title = "Ваші питання"
  end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end
end
