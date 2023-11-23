class Api::V1::MessagesController < ApplicationController
  include Panko
  before_action :doorkeeper_authorize!

  def index
    @messages = Message.all
    render json: ArraySerializer.new(@messages, each_serializer: MessageSerializer).to_json
  end

  def create
    message = {sender_id: current_user.id}.merge(message_params)
    @message = Message.new(message)
    authorize @message

    if @message.save
      render json: MessageSerializer.new.serialize(@message).to_json, status: :created, location: api_v1_message_url(@message)
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.permit(:conversation_id, :body)
  end
end