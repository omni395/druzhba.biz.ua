class ArticlesController < ApplicationController
  before_action { @page_title = "Блог швейної майстерні ☞ДРУЖБА☜" }
  before_action { @page_description }

  def index
    @articles = Article.all
  end

  def show
    @article = Article.friendly.find(params[:id])
    @page_title = @article.title
    @page_description = "Блог швейної майстерні ☞ ДРУЖБА ☜ - " + @page_title
  end

end