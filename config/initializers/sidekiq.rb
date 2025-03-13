# frozen_string_literal: true

Sidekiq.configure_client do |config|
  url = "redis://127.0.0.1:6379/12"
  puts url
  config.redis = { url:, size: 4, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  url = "redis://127.0.0.1:6379/12"
  puts url
  config.redis = { url:, size: 4, network_timeout: 5 }
end
