# frozen_string_literal: true

module Admin
  module AdminUsers
    class RegistrationsController < Devise::RegistrationsController
      layout 'admin'

      # before_action :configure_sign_up_params, only: [:create]
      before_action :configure_account_update_params, only: [:update]

      # GET /resource/sign_up
      def new
        raise Forbidden
      end

      # POST /resource
      def create
        raise Forbidden
      end

      # GET /resource/edit
      # def edit
      #   super
      # end

      # PUT /resource
      # def update
      #   if params[:user][:password].blank?
      #     params[:user].delete("password")
      #     params[:user].delete("password_confirmation")
      #   end
      #   super
      # end

      # DELETE /resource
      def destroy
        raise Forbidden
      end

      # GET /resource/cancel
      # Forces the session data which is usually expired after sign
      # in to be expired now. This is useful if the user wants to
      # cancel oauth signing in/up in the middle of the process,
      # removing all OAuth session data.
      # def cancel
      #   super
      # end

      protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_up_params
      #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
      # end

      # If you have extra params to permit, append them to the sanitizer.
      def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: %i[name role])
      end

      def update_resource(resource, params)
        resource.password = params[:password] if params[:password].present?
        resource.update_without_password(params)
      end

      # The path used after sign up.
      def after_update_path_for(_resource)
        edit_admin_user_registration_path
      end

      # The path used after sign up for inactive accounts.
      # def after_inactive_sign_up_path_for(resource)
      #   super(resource)
      # end
    end
  end
end
