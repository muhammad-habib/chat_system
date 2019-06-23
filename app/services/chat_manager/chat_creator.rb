module ChatManager
  class ChatCreator < BaseService
    attr_reader :application

    def initialize(app)
      @application = app
    end

    def call
      ChatCreationJob.set(queue: 'chat').perform_later(@application)
    end
  end
end