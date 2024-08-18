class ArticlesController < ApplicationController
  before_action { @page_title = "Блог швейної майстерні ☞ДРУЖБА☜" }
  before_action { @page_description }

  def index
    @pagy, @articles = pagy(Article.published)
    #sleep(20)
    respond_to do |format|
      format.html 
      format.turbo_stream
    end

    if I18n.locale == :uk
      @page_title = "Швейна майстерня ☞ ДРУЖБА ☜ - Наш Блог. Ділимося досвідом, навичками та прикладами робіт."
      @page_description = "Блог швейної майстерні ☞ДРУЖБА☜ - Наш досвід та майстерність, і як ми створюємо звичайні та незвичайні речі. Приклади робіт, покрокові інструкції та безліч порад!"
    else
      @page_title = "Швейная мастерская ☞ ДРУЖБА ☜ - Наш Блог. Делимся опытом, навыками и примераами работ."
      @page_description = "Блог швейной мастерской ☞ДРУЖБА☜ - Наш опыт и мастерство, и как мы создаем обычные и необычные вещи. Примеры работ, пошаговые инструкции и множество советов!"
    end
  end

  def show
    @article = Article.friendly.find(params[:id]) if Article.published
    @page_title = @article.title
    @page_description = "Блог швейної майстерні ☞ ДРУЖБА ☜ - " + @page_title
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

end