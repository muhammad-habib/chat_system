module Auth
  extend ActiveSupport::Concern

  def appAuth(headers)
    puts headers.inspect
  end
end