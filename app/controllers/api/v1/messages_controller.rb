class Api::V1::MessagesController < ApplicationController
  before_action :checkChat, only: [:create, :index]
  include(MessageManager)

  # GET /messsages
  def index
    @messsages = Message.all

    render json: @messsages
  end

  # GET /messsages/1
  def show
    render json: @messsage
  end

  # POST /messsages
  def create
    MessageManager::MessageCreator.call(params[:chat], params[:body])
    render json: { msg: 'Message Created Successfully' }, status: :created
  end

  # PATCH/PUT /messsages/1
  def update
    if @messsage.update(messsage_params)
      render json: @messsage
    else
      render json: @messsage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messsages/1
  def destroy
    @messsage.destroy
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
end
