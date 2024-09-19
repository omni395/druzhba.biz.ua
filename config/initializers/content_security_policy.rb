Rails.application.configure do
  config.content_security_policy do |policy|
    nonce = SecureRandom.base64(16)
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.style_src   :self, :https, :unsafe_inline, "nonce-#{nonce}"
    policy.script_src  :self, :https, :unsafe_inline, "nonce-#{nonce}", 'https://cdnjs.cloudflare.com', 'https://www.googletagmanager.com'
  end
end