class Message < ApplicationRecord
  validates :chat_id, :body, presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: :english
    end
  end

  def as_json(options={})
    {
        :message_number => message_number,
        :body => body
    }
  end
end
