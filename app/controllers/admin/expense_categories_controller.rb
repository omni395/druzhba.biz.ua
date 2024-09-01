module Admin
  class ExpenseCategoriesController < BaseController
    before_action { @page_title = 'Категорія доходів (витрат)' }

    def index
      @search = ExpenseCategorySearchForm.new(search_params)
      @expense_categories = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @expense_category = ExpenseCategory.find(params[:id])
    end

    def new
      @expense_category = ExpenseCategory.new
    end

    def create
      @expense_category = ExpenseCategory.new
      @expense_category.assign_attributes(post_params)
      if @expense_category.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @expense_category = ExpenseCategory.find(params[:id])
    end

    def update
      @expense_category = ExpenseCategory.find(params[:id])
      @expense_category.assign_attributes(post_params)
      if @expense_category.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @expense_category = ExpenseCategory.find(params[:id])
      if @expense_category.destroy
        redirect_to admin_expense_categories_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :title_full_like,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_expense_category).permit(
        :title,
        :description
      )
    end
  end
end