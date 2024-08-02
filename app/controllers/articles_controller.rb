class ArticlesController < ApplicationController
  before_action { @page_title = "Блог швейної майстерні ☞ДРУЖБА☜" }
  before_action { @page_description }

  def index
    @articles = Article.all
    @page_description = "Блог швейної майстерні ☞ДРУЖБА☜ - Наш досвід та майстерність, і як ми створюємо звичайні та незвичайні речі. Приклади робіт, покрокові інструкції та безліч порад!"
  end

  def show
    @article = Article.friendly.find(params[:id])
    @page_title = @article.title
    @page_description = "Блог швейної майстерні ☞ ДРУЖБА ☜ - " + @page_title
  end

end