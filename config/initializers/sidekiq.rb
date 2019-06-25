# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379' }
  # chain.add Middleware::Sidekiq::Server::ErrorLogger, :foo => 1, :bar => 2
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::Chat
  end
  # accepts :expiration (optional)
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes

  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379' }
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end