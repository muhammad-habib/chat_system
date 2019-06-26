class Api::V1::MessagesController < ApplicationController
  before_action :checkChat, only: [:index, :search, :create]
  before_action :checkMessageBody, only: [:create]
  before_action :checkQuery, only: [:search]
  # GET /messsages
  def index
    render json: MessageManager::MessageLister.call(params[:chat]), except: [:chat_id]
  end

  # GET /messsages/1
  def show
    render json: @messsage
  end

  # POST /messsages
  def create
    message_number = MessageManager::MessageCreator.call(params[:chat], params[:body])
    render json: {message_number: message_number}, status: :created
  end


  def search
    query = params[:query]
    if query
      @messages = Message.search_messages(query, params[:chat].id)
      render json: @messages
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_messsage
    @messsage = Message.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def messsage_params
    params.permit(:app_token, :body)
  end

  def checkChat
    @application = Application.find_by_app_token(params[:app_token])
    if !@application
      render json: {msg: 'application not found'}, status: :not_found
    else
      @chat = Chat.where(application_id: @application.id, chat_number: params[:chat_number]).take
      if !@chat
        render json: {msg: 'chat not found'}, status: :not_found
      else
          params[:chat] = @chat
      end
    end
  end

  def checkMessageBody
    if !params[:body].present?
      render json: {msg: 'body not found'}, status: :not_found
    end
  end

  def checkQuery
    if !params[:query].present?
      render json: {msg: 'query param not found'}, status: :not_found
    end
  end
end
