module MessageManager
  class MessageCreator < BaseService
    attr_reader :chat, :body

    def initialize(chat, body)
      @chat = chat
      @body = body
    end

    def call
      job = MessageCreationJob.set(queue: 'message').perform_later(@chat, @body)
      while !Sidekiq::Status::complete?    job.provider_job_id do
        sleep 1
      end
      Sidekiq::Status::get job.provider_job_id, :message_number
    end
  end
end