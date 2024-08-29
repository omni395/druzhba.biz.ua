# frozen_string_literal: true

module Admin
  class MoneyFlowCategoriesController < BaseController
    before_action { @page_title = 'Категорія доходів (витрат)' }

    def index
      @search = MoneyFlowCategorySearchForm.new(search_params)
      @money_flow_categories = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @money_flow_category = MoneyFlowCategory.find(params[:id])
    end

    def new
      @money_flow_category = MoneyFlowCategory.new
    end

    def create
      @money_flow_category = MoneyFlowCategory.new
      @money_flow_category.assign_attributes(post_params)
      if @money_flow_category.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @money_flow_category = MoneyFlowCategory.find(params[:id])
    end

    def update
      @money_flow_category = MoneyFlowCategory.find(params[:id])
      @money_flow_category.assign_attributes(post_params)
      if @money_flow_category.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @money_flow_category = MoneyFlowCategory.find(params[:id])
      if @money_flow_category.destroy
        redirect_to admin_money_flow_categories_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
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
        :sort_kind,
        flow_any: []
      )
    end

    def post_params
      params.require(:admin_money_flow_category).permit(
        :title,
        :description,
        :flow
      )
    end
  end
end
