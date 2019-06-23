class Message < ApplicationRecord
  validates :chat_id, :body, presence: true
  def as_json(options={})
    {
        :message_number => message_number,
        :body => body
    }
  end
end
