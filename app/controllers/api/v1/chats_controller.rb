class Api::V1::ChatsController < ApplicationController
  before_action :checkToken, only: [:create, :index]

  # GET /chats
  def index
    render json: ChatManager::ChatLister.call(params[:app])
  end


  # POST /chats
  def create
    chat_num = ChatManager::ChatCreator.call(params[:app])
    render json: {chat_number: chat_num}, status: :created
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def chat_params
    params.permit(:app_token)
  end

  def checkToken
    @application = Application.find_by_app_token(params[:app_token])
    if !@application
      render json: {msg: 'application not found'}, status: :not_found
    else
      params[:app] = @application
    end
  end
end
