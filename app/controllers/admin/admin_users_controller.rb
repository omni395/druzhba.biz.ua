module Admin
  class AdminUsersController < BaseController
    before_action { @page_title = 'Користувач системи' }

    def index
      @search = AdminUserSearchForm.new(search_params)
      @admin_users = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @admin_user = AdminUser.find(params[:id])
    end

    def new
      @admin_user = AdminUser.new
    end

    def create
      @admin_user = AdminUser.new
      @admin_user.assign_attributes(post_params)
      if @admin_user.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @admin_user = AdminUser.find(params[:id])
    end

    def update
      @admin_user = AdminUser.find(params[:id])
      @admin_user.assign_attributes(post_params)
      if @admin_user.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @admin_user = AdminUser.find(params[:id])
      if @admin_user.destroy
        redirect_to admin_admin_users_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :email_eq,
        :name_full_like,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_admin_user).permit(
        :email,
        :name,
        :password
      )
    end
  end
end