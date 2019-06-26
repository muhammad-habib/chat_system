class Message < ApplicationRecord
  validates :chat_id, :body, presence: true
  validates :body, presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: :english
      indexes :chat_id, type: :integer
    end
  end



  def self.search_messages(query, chat_id)

    self.search({
                    query: {
                        bool: {
                            must: [
                                {
                                    multi_match: {
                                        query: query,
                                        fields: [:body]
                                    }
                                },
                                {
                                    match: {
                                        chat_id: chat_id
                                    }
                                }]
                        }
                    },
                    '_source': ['body', 'message_number']
                })

  end
end
