module ChatManager
  class ChatLister < BaseService
    attr_reader :application

    def initialize(app)
      @application = app
    end

    def call
      @application.chats
    end
  end
end