class ChatCreationJob < ActiveJob::Base
  include Sidekiq::Status::Worker
  queue_as :chat

  def perform(application)
    lastChat = application.chats().last
    lastChatNumber = lastChat ? lastChat.chat_number : 0
    @chat = Chat.new(chat_number: lastChatNumber + 1, application_id: application.id)
    @chat.save
    store chat_num: @chat.chat_number
    application.increment!(:chats_count)
  end
end