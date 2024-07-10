class LandingMessagesController < ApplicationController

  def new
    @landing_message = LandingMessage.new
  end

  def create
    @landing_message = LandingMessage.new
    @landing_message.assign_attributes(landing_message_params)

    respond_to do |format|
      if @landing_message.save
        MessageNotifierMailer.new_message_email(@landing_message, 'ksuha@druzhba.biz.ua', 'Нове повідомлення від #{@landind_message.name}').deliver_now
        MessageNotifierMailer.new_message_email(@landing_message, 'admin@druzhba.biz.ua').deliver_now
        format.html { redirect_back fallback_location: root_path }
        flash.now[:notice] = 'Повідомлення відпраавлено'
      else
        format.html { redirect_to root_path, status: :unprocessable_entity}
        flash.now[:alert] = t('infold.flash.invalid')
      end
    end
  end

  private
  def landing_message_params
    params.require(:landing_message).permit(:name, :phone, :email, :message)
  end
end