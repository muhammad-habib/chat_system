class Application < ApplicationRecord
  validates :name, presence: true
  has_secure_token :app_token

  def as_json(options={})
    {
        :name => name,
        :app_token => app_token
    }
  end
end
