class Chat < ApplicationRecord
  validates :application_id, presence: true
  has_many :messages
  def as_json(options={})
    {
        :chat_number => chat_number
    }
  end
end
