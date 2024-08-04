class LandingController < ApplicationController
  before_action { @page_title }
  before_action { @page_description }

  def index
    #session[:cookies_accepted] = nil
    if I18n.locale == :uk
      @page_title = "☞ДРУЖБА☜ Кравець Кривий Ріг Більше 15 Років Досвіду Якість Та Ціна"
      @page_description = "Шукаєте ідеальний ремонт одягу? Ми пропонуємо якісний ремонт та ексклюзивне пошиття одягу. Завітайте до нас. Довіртеся майстрам!"
    else
      @page_title = "☞ДРУЖБА☜ Портной Кривой Рог Более 15 Лет Опыта Качество И Цена"
      @page_description = "Ищете идеальный ремонт одежды? Мы предлагаем качественный ремонт и эксклюзивный пошив одежды. Загляните к нам. Доверьтесь мастерам!"
    end
  end

  def prices
    @repair = Service.repair
    @sewing = Service.sewing
    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ДРУЖБА☜ - Наші ціни"
      @page_description = "Інформація про ціни на послуги швейної майстерні ☞ДРУЖБА☜: перешивання, кастомізація, ремонт, індивідуальний пошив. Знижки та пропозиції для наших клієнтів!"
    else
      @page_title = "Швейная мастерская ☞ДРУЖБА☜ - Наши цены"
      @page_description = "Информация о ценах на услуги швейной мастерской ☞ДРУЖБА☜: перешивка, кастомизация, ремонт, индивидуальный пошив. Скидки и предложения для наших клиентов!"
    end
  end

  def about
    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ДРУЖБА☜ - Про нас"
      @page_description = "це місце, де кожен шов створюється з любов'ю до деталей та увагою до клієнтів. Наші переваги - професіоналізм, індивідуальний підхід та відмінна якість кожного виробу."
    else
      @page_title = "Швейная мастерская ☞ДРУЖБА☜ - О нас"
      @page_description = "это место, где каждый шов создается с любовью к деталям и вниманием к клиентам. Наши преимущества – профессионализм, индивидуальный подход и отличное качество каждого изделия."
    end
  end

  def contacts
    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ДРУЖБА☜ - Контакти"
      @page_description = "Знайдіть нас легко завдяки розділу «Контакти» нашої швейної майстерні ☞ДРУЖБА☜. Тут ви знайдете карти та схему проїзду та адресу."
    else
      @page_title = "Швейная мастерская ☞ДРУЖБА☜ - Контакты"
      @page_description = "Найдите нас благодаря разделу «Контакты». Здесь вы найдете карты и схему проезда и адреса."
    end
  end

  def faq
    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ДРУЖБА☜ - Ваші запитання"
      @page_description = "Знайдіть відповіді на найчастіші питання або задайте своє питання на нашому сайті. Все, що вам потрібно знати про нашу майстерню, знаходиться тут!"
    else
      @page_title = "Швейная мастерская ☞ДРУЖБА☜ - Вашы вопросы"
      @page_description = "Найдите ответы на самые частые вопросы или задайте свой вопрос на нашем сайте. Все, что вам нужно знать о нашей мастерской находится здесь!"
    end
  end

  def policy
    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ДРУЖБА☜ - Умови використання"
      @page_description = "Умови використання"
    else
      @page_title = "Швейная мастерская ☞ДРУЖБА☜ - Условия использования"
      @page_description = "Условия использования"
    end
  end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end
end
