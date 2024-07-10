class MessageNotifierMailer < ApplicationMailer
  def new_message_email(landing_message, email)
    @landing_message = landing_message
    @email = email
    mail(to: email, subject: landing_message.name)
  end
end
