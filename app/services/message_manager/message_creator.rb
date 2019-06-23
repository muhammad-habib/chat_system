module MessageManager
  class MessageCreator < BaseService
    attr_reader :chat, :body

    def initialize(chat, body)
      @chat = chat
      @body = body
    end

    def call
      MessageCreationJob.set(queue: 'message').perform_later(@chat, @body)
    end
  end
end