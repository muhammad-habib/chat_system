class CleanupJob < ActiveJob::Base
  queue_as :default

  def perform
    aps = Application.new
    puts 'hi'
    aps.name = 'asdasdasd'
    t = Time.now        #=> 2007-11-17 15:18:03 +0900
    aps.app_token = "%10.9f" % t.to_f
    aps.save
  end
end