class Application < ApplicationRecord
  validates :name, presence: true
  has_secure_token :app_token
  has_many :chats

  def as_json(options={})
    {
        :name => name,
        :app_token => app_token
    }
  end
end
