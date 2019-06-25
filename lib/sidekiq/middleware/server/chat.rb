module Sidekiq::Middleware::Server
  class Chat
    def call(worker, item, queue)
      klass = item['class']
      args = item['args']
      Rails.logger.info("Performing #{klass} with ccccccccccc arguments: #{args}")

      yield
    end
  end
end