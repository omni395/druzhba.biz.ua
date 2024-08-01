module Admin
  class OrdersController < BaseController
    before_action { @page_title = 'Замовлення' }

    def index
      @search = OrderSearchForm.new(search_params)
      @orders = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      @order = Order.new
      @order.order_details.build
    end

    def create
      @order = Order.new
      @order.assign_attributes(post_params)
      if @order.save

        add_money_flow_record(@order)

        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])
      @order.assign_attributes(post_params)
      if @order.save

        add_money_flow_record(@order)

        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @order = Order.find(params[:id])
      if @order.destroy

        add_money_flow_record(@order)
        
        redirect_to admin_orders_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def add_money_flow_record(order)
      # Запись создается, только если заказ оплачен
      if order.paid == 1
        m = MoneyFlow.new
        m.admin_user_id = order.admin_user_id
        m.title = "Надходження від замовлення #{order.id}, від #{order.created_at}"
        m.description = "Опис надходження від замовлення"
        m.total_amount = order.price
        m.money_flow_details.build(amount: order.price, money_flow_category_id: "1")
        m.save
      end
    end

    def search_params
      params[:search]&.permit(
        :customer_id_eq,
        :admin_user_id_eq,
        :sort_field,
        :sort_kind,
        status_any: [],
        paid_any: []
      )
    end

    def post_params
      params.require(:admin_order).permit(
        :customer_id,
        :admin_user_id,
        :price,
        :description,
        :dead_date,
        :dead_time,
        :status,
        :paid,
        order_details_attributes: [
          :id,
          :_destroy,
          :service_id
        ],
        money_flows_attributes: [
          :id,
          :_destroy,
          :admin_user_id,
          :title,
          :description,
          :amount,
          money_flow_deails_attributes: [
            :id,
            :money_flow_category_id,
            :_destroy,
            :amount
          ]
        ]
      )
    end
  end
end