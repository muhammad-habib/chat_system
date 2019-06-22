class SleepingJob < ActiveJob::Base
  def self.queue
    :default
  end

  def self.perform
    aps = Application.new
    aps.name = 'asdasdasd'
    t = Time.now        #=> 2007-11-17 15:18:03 +0900
    aps.app_token = "%10.9f" % t.to_f
    aps.save
  end
end