module Admin
  class ServicesController < BaseController
    before_action { @page_title = 'Послуги' }

    def index
      @search = ServiceSearchForm.new(search_params)
      @services = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @service = Service.friendly.find(params[:id])
    end

    def new
      @service = Service.new
    end

    def create
      @service = Service.new
      @service.assign_attributes(post_params)
      if @service.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @service = Service.friendly.find(params[:id])
    end

    def update
      @service = Service.find(params[:id])
      @service.assign_attributes(post_params)
      if @service.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @service = Service.find(params[:id])
      if @service.destroy
        redirect_to admin_services_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
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
      params.require(:admin_service).permit(
        :title,
        :image,
        :remove_image,
        :description
      )
    end
  end
end