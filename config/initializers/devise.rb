Devise.setup do |config|

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  config.secret_key = 'f83e2bc868618ae71aee4c526c23b08a89e2aa4295b41db0c23140b47111a7098b942aba243a54fd41770e8681071cb08831119157941ef634525e5c387d537a'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

#パスワードの長さ
  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.mailer_sender = 'noreply@yourdomein'

#APIキーの設定
  if Rails.env.production? #本番環境
    config.omniauth :facebook, '748253041983289', '914d34db453aef1723e69f7dff804b8c',
    scope: 'email', display: 'popup',
    info_fields: 'name, email'
    config.omniauth :twitter, 'Gk2d2Nl1vfaVkGHlKSKUoI8VC', 'qdNR3utf4LoXKifKfn6iKgB2qINQsdnwKqv4isWaB37op9pcDm'
  else                     #開発環境
    config.omniauth :facebook, '485395438327175', 'f3ac91a414d7e102ae2dff4d9149741d',
    scope: 'email', display: 'popup',
    info_fields: 'name, email'
    config.omniauth :twitter, 'tl50qNOYnDdVUDg2WFnDZsfvB', '7zBlT9EeQidRop32ZVjpdSIBl3oAcnEPhsQeJH9IG2rfgIjVTR'
  end

end
