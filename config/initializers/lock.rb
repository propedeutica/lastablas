
# lock_config = Rails.application.config_for(:lock)

Rails.application.configure do
  config.lock = ActiveSupport::OrderedOptions.new
  config.lock.status = false
end
