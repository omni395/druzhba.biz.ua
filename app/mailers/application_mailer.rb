# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@druzhba.biz.ua'
  layout 'mailer'
end
