module Admin
  class ArticlesController < BaseController
    before_action { @page_title = 'Назва' }

    def index
      @search = ArticleSearchForm.new(search_params)
      @articles = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @article = Article.friendly.find(params[:id])
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new
      @article.assign_attributes(post_params)
      if @article.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @article = Article.friendly.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])
      @article.assign_attributes(post_params)
      if @article.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find(params[:id])
      if @article.destroy
        redirect_to admin_articles_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :service_id_eq,
        :published_eq,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_article).permit(
        :service_id,
        :published,
        :title,
        :image,
        :remove_image,
        :description,
        :body
      )
    end
  end
end