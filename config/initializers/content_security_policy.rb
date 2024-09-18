Rails.application.configure do
  config.content_security_policy do |policy|
    nonce = SecureRandom.base64(16)
    policy.default_src :self, :https
    policy.font_src    :self, :https, 'https://fonts.googleapis.com'
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.style_src   :self, :https, 'https://fonts.googleapis.com', "nonce-#{nonce}"
    policy.script_src  :self, :https, 'https://cdnjs.cloudflare.com', 'https://www.googletagmanager.com', "nonce-#{nonce}"
    policy.script_src_attr :self, :https, 'https://cdnjs.cloudflare.com', 'https://www.googletagmanager.com'
  end
end