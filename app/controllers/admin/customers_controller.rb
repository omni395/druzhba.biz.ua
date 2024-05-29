module Admin
  class CustomersController < BaseController
    before_action { @page_title = 'Замовники' }

    def index
      @search = CustomerSearchForm.new(search_params)
      @customers = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @customer = Customer.find(params[:id])
    end

    def new
      @customer = Customer.new
    end

    def create
      @customer = Customer.new
      @customer.assign_attributes(post_params)
      if @customer.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @customer = Customer.find(params[:id])
    end

    def update
      @customer = Customer.find(params[:id])
      @customer.assign_attributes(post_params)
      if @customer.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @customer = Customer.find(params[:id])
      if @customer.destroy
        redirect_to admin_customers_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :name_full_like,
        :phone_full_like,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_customer).permit(
        :name,
        :phone,
        :description
      )
    end
  end
end