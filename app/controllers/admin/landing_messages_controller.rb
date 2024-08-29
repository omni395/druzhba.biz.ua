# frozen_string_literal: true

module Admin
  class LandingMessagesController < BaseController
    before_action { @page_title = 'Повідомлення' }

    def index
      @search = LandingMessageSearchForm.new(search_params)
      @landing_messages = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @landing_message = LandingMessage.find(params[:id])
    end

    def new
      @landing_message = LandingMessage.new
    end

    def create
      @landing_message = LandingMessage.new
      @landing_message.assign_attributes(post_params)
      if @landing_message.save
        flash.now[:notice] = t('infold.flash.created')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @landing_message = LandingMessage.find(params[:id])
    end

    def update
      @landing_message = LandingMessage.find(params[:id])
      @landing_message.assign_attributes(post_params)
      if @landing_message.save
        flash.now[:notice] = t('infold.flash.updated')
        render :form
      else
        flash.now[:alert] = t('infold.flash.invalid')
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @landing_message = LandingMessage.find(params[:id])
      if @landing_message.destroy
        redirect_to admin_landing_messages_path, status: :see_other, flash: { notice: t('infold.flash.destroyed') }
      else
        flash.now[:alert] = t('flash.invalid_destroy')
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :name_full_like,
        :email_full_like,
        :sort_field,
        :sort_kind,
        status_any: []
      )
    end

    def post_params
      params.require(:admin_landing_message).permit(
        :name,
        :phone,
        :email,
        :message,
        :status
      )
    end
  end
end
