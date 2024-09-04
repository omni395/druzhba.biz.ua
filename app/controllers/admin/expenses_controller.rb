# frozen_string_literal: true

module Admin
  class ExpensesController < BaseController
    before_action { @page_title = 'Надходження (витрати)' }

    def index
      @search = ExpenseSearchForm.new(search_params)
      @expenses = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @expense = Expense.find(params[:id])
    end

    def new
      @expense = Expense.new
    end

    def create
      @expense = Expense.new
      @expense.assign_attributes(post_params)
      if @expense.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @expense = Expense.find(params[:id])
    end

    def update
      @expense = Expense.find(params[:id])
      @expense.assign_attributes(post_params)
      if @expense.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @expense = Expense.find(params[:id])
      if @expense.destroy
        redirect_to admin_expenses_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :admin_user_id_eq,
        :expense_category_id_eq,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_expense).permit(
        :admin_user_id,
        :expense_category_id,
        :amount,
        :title,
        :description
      )
    end
  end
end
