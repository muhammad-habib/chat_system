class ChatCreationJob < ActiveJob::Base
  @queue = :chat

  def perform(application)
    lastChat = application.chats().last
    lastChatNumber = lastChat ? lastChat.chat_number : 0
    @chat = Chat.new(chat_number: lastChatNumber + 1, application_id: application.id)
    @chat.save
    application.increment!(:chats_count)
  end
end