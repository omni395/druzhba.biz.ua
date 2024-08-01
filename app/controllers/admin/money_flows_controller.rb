module Admin
  class MoneyFlowsController < BaseController
    before_action { @page_title = 'Надходження (витрати)' }

    def index
      @search = MoneyFlowSearchForm.new(search_params)
      @money_flows = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @money_flow = MoneyFlow.find(params[:id])
    end

    def new
      @money_flow = MoneyFlow.new
      @money_flow.money_flow_details.build
    end

    def create
      @money_flow = MoneyFlow.new
      @money_flow.assign_attributes(post_params)
      if @money_flow.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @money_flow = MoneyFlow.find(params[:id])
    end

    def update
      @money_flow = MoneyFlow.find(params[:id])
      @money_flow.assign_attributes(post_params)
      if @money_flow.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @money_flow = MoneyFlow.find(params[:id])
      if @money_flow.destroy
        redirect_to admin_money_flows_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :admin_user_id_eq,
        :money_flow_category_id_eq,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_money_flow).permit(
        :admin_user_id,
        :title,
        :description,
        money_flow_details_attributes: [
          :id,
          :_destroy,
          :money_flow_category_id,
          :amount
        ]
      )
    end
  end
end