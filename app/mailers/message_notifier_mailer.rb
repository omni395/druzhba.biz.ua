class MessageNotifierMailer < ApplicationMailer
  def new_message_email(landing_message, email, subject)
    @landing_message = landing_message
    @email = email
    @subject = subject
    mail(to: email, subject: subject)
  end
end
