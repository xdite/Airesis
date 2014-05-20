Recaptcha.configure do |config|
  config.public_key  = Setting.recaptcha.public_key
  config.private_key = Setting.recaptcha.private_key
end