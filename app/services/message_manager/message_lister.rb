module MessageManager
  class MessageLister < BaseService
    attr_reader :chat

    def initialize(chat)
      @chat = chat
    end

    def call
      @chat.messages
    end
  end
end