class ServicesController < ApplicationController
  before_action { @page_title = "Послуги швейної майстерні ☞ДРУЖБА☜ у Кривому Розі" }
  before_action { @page_description }

  def index
    @services = Service.order(id: :asc)
    if I18n.locale == :uk
      @page_title = "🌟 Послуги швейної майстерні ☞ДРУЖБА☜ (Ательє Кривий Ріг)"
      @page_description = "Послуги портной у швейної майстерні ☞ДРУЖБА☜ у Кривому Розі. Якісний ремонт будь-якої складності та індивідуальний пощив одягу"
    else
      @page_title = "🌟 Услуги швейной мастерской ☞ДРУЖБА☜ (Ателье Кривой Рог)"
      @page_description = "Услуги портной в швейной мастерской ☞ДРУЖБА☜ в Кривом Роге. Качественный ремонт любой сложности и индивидуальный покров одежды"
    end
  end

  def show
    @service = Service.friendly.find(params[:id])
    if I18n.locale == :uk
      @page_title = @service.subtitle
      @page_description = "Послуга швейної майстерні ☞ДРУЖБА☜ - " + @service.description
    else
      @page_title = @service.subtitle
      @page_description = "Услуга швейной мастерской ☞ДРУЖБА☜ -" + @service.description
    end
  end

end