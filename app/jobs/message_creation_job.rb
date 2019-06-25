class MessageCreationJob < ActiveJob::Base
  include Sidekiq::Status::Worker
  queue_as :message
  def perform(chat, body)
    lastMessage = chat.messages().last
    lastMessageNumber = lastMessage ? lastMessage.message_number : 0
    @message = Message.new(message_number: lastMessageNumber + 1, chat_id: chat.id, body: body)
    @message.save
    store message_number: @message.message_number
    chat.increment!(:messages_count)
  end
end