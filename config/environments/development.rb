Rails.application.configure do

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        "smtp.gmail.com",
    port:           587,
    authentication: "plain",
    user_name:      "ikkiiimonkey0229@gmail.com",
    password:       "ehvrebwbjvmmewkc",
    domain:         'smtp.gmail.com',
    enable_starttls_auto: true
  }

  require 'pusher'
  Pusher.app_id = '219761'
  Pusher.key = '9abd67f0c3b911b1da12'
  Pusher.secret = '0f26402d615f293b4d61'

  #deviseの設定
  config.action_mailer.default_url_options = { host: 'localhost:3000' }


end
