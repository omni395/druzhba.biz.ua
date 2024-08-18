class ServicesController < ApplicationController
  before_action { @page_title = "Послуги швейної майстерні ☞ДРУЖБА☜ у Кривому Розі" }
  before_action { @page_description }

  caches_page :index, :show, gzip: :best_speed

  def index
    @services = Service.order(id: :asc)
    if I18n.locale == :uk
      @page_title = "🌟 Послуги швейної майстерні ☞ДРУЖБА☜ (Ательє Кривий Ріг)"
      @page_description = "Майстерня ☞ДРУЖБА☜ у Кривому Розі. Якісний ремонт будь-якої складності та індивідуальний пощив одягу"
    else
      @page_title = "🌟 Услуги швейной мастерской ☞ДРУЖБА☜ (Ателье Кривой Рог)"
      @page_description = "Ателье ☞ДРУЖБА☜ в Кривом Роге. Качественный ремонт любой сложности и индивидуальный покров одежды"
    end
  end

  def show
    @service = Service.friendly.find(params[:id])
    if I18n.locale == :uk
      @page_title = @service.subtitle
      @page_description = "Майстерня ☞ДРУЖБА☜ - " + @service.description
    else
      @page_title = @service.subtitle
      @page_description = "Ателье ☞ДРУЖБА☜ -" + @service.description
    end
  end

end