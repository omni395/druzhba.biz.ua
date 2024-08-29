# frozen_string_literal: true

class MessageNotifierMailer < ApplicationMailer
  def new_message_email(landing_message, email)
    @landing_message = landing_message
    @email = email
    mail(to: email, subject: "Нове повідомлення від #{landing_message.name}")
  end
end
