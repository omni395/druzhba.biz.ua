class ServicesController < ApplicationController
  before_action { @page_title = "Послуги швейної майстерні у Кривому Розі" }
  before_action { @page_description }

  def index
    @services = Service.order(id: :asc)
    @page_description = "Послуги швейної майстерні ☞ДРУЖБА☜ у Кривому Розі. Якісний ремонт будь-якої складності та індивідуальний пощив одягу"
  end

  def show
    @service = Service.friendly.find(params[:id])
    @page_title = @service.title
    @page_description = "Послуга швейної майстерні ☞ДРУЖБА☜ - " + @service.subtitle
  end

end