class ServicesController < ApplicationController
  before_action { @page_title = "Послуги" }

  def index
    @services = Service.order(id: :asc)
  end

  def show
    @service = Service.friendly.find(params[:id])
    @page_title = @service.title
  end

end