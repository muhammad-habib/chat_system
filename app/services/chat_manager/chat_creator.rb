module ChatManager
  class ChatCreator < BaseService
    attr_reader :application

    def initialize(app)
      @application = app
    end

    def call
      job = ChatCreationJob.perform_later(@application)
      while !Sidekiq::Status::complete?    job.provider_job_id do
        sleep 1
      end
      Sidekiq::Status::get job.provider_job_id, :chat_num
    end
  end
end