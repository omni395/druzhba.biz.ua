# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Internationalization
  include Pagy::Backend
  include ActionController::Caching

  before_action :set_csp_nonce

  private

  def set_csp_nonce
    @csp_nonce = SecureRandom.base64(16)
    
    script_src = Rails.application.config.content_security_policy&.script_src
    style_src = Rails.application.config.content_security_policy&.style_src
    script_src_attr = Rails.application.config.content_security_policy&.script_src_attr
    
    #script_src_string = script_src.is_a?(Array)? script_src.join(' ') : "'self' https: 'unsafe-inline'"
    #style_src_string = style_src.is_a?(Array)? style_src.join(' ') : "'self' https: 'unsafe-inline'"
    #script_src_attr_string = script_src_attr.is_a?(Array)? script_src_attr.join(' ') : "'self' https: 'unsafe-inline'"
    
    #response.headers['Content-Security-Policy'] = "script-src 'nonce-#{@csp_nonce}' #{script_src_string}; script-src-attr #{script_src_attr_string};"
  end
  
end
