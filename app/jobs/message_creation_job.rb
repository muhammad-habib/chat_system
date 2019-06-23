class MessageCreationJob < ActiveJob::Base
  @queue = :message

  def perform(chat, body)
    lastMessage = chat.messages().last
    lastMessageNumber = lastMessage ? lastMessage.message_number : 0
    @message = Message.new(message_number: lastMessageNumber + 1, chat_id: chat.id, body: body)
    @message.save
    chat.increment!(:messages_count)
  end
end