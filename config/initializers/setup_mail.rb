ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "techclt.com",
  :user_name            => "welcome@techclt.com",
  :password             => GMAIL_PASSWORD,
  :enable_starttls_auto => true
}

# ActionMailer::Base.smtp_settings = {
#   :address              => "smtp.gmail.com",
#   :port                 => 587,
#   :domain               => "gotcup.com",
#   :user_name            => "noreply@gotcup.com",
#   :password             => "12Monkeys",
#   :enable_starttls_auto => true
# }


ActionMailer::Base.default_url_options[:host] = "techclt.com" if Rails.env.production?
#ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevMailInterceptor) if Rails.env.development?
#Mail.register_interceptor(ProductionMailInterceptor) if Rails.env.production?



