class ArticlesController < ApplicationController
  before_action { @page_title = "Статті" }

  def index
    @articles = Article.all
  end

  def show
    @article = Article.friendly.find(params[:id])
    @page_title = @article.title
  end

end