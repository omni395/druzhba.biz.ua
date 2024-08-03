class LandingController < ApplicationController
  before_action { @page_title }
  before_action { @page_description }

  def index
    #session[:cookies_accepted] = nil
    @page_description = "Швейна майстерня ☞ ДРУЖБА ☜ у Кривому Розі. Шукаєте ідеальний ремонт одягу? Ми пропонуємо якісний ремонт та ексклюзивне пошиття одягу. Довіртеся майстрам!"
  end

  def prices
    @repair = Service.repair
    @sewing = Service.sewing
    @page_title = "Ціни"
    @page_description = "Інформація про ціни на послуги швейної майстерні ☞ДРУЖБА☜: перешивання, кастомізація, ремонт, індивідуальний пошив. Знижки та пропозиції для наших клієнтів!"
  end

  def about
    @page_title = "Про нас"
    @page_description = "Швейна майстерня ☞ДРУЖБА☜ - це місце, де кожен шов створюється з любов'ю до деталей та увагою до клієнтів. Наші переваги - професіоналізм, індивідуальний підхід та відмінна якість кожного виробу."
  end

  def contacts
    @page_title = "Контакти"
    @page_description = "Знайдіть нас легко завдяки розділу «Контакти» нашої швейної майстерні ☞ДРУЖБА☜. Тут ви знайдете карти та схему проїзду та адресу."
  end

  def faq
    @page_title = "Ваші питання"
    @page_description = "Знайдіть відповіді на найчастіші питання щодо швейної майстерні ☞ДРУЖБА☜ та задайте своє питання на нашому сайті. Все, що вам потрібно знати про нашу майстерню, знаходиться тут!"
  end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end
end
