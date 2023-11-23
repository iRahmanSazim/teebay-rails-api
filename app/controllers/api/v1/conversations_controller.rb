class Api::V1::ConversationsController < ApplicationController
  include Panko
  before_action :doorkeeper_authorize!

  def index
    @conversations = Conversation.all
    authorize @conversations
    render json: @conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    render json: @conversation
  end

  def find_messages_by_conversation
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    @messages = Message.where(conversation_id: params[:id])
    render json: ArraySerializer.new(@messages, each_serializer: MessageSerializer).to_json
  end

  def find_by_user
    @conversations = Conversation.where(":current_user_id = ANY(participant_ids)", {current_user_id: [current_user.id]})
    authorize @conversations
    render json: ArraySerializer.new(@conversations, each_serializer: ConversationSerializer).to_json
  end

  def create 
    product = Product.find(params[:product_id])
    render json: {message: 'Product not found'} unless product

    participant_ids = [product.user_id, current_user.id]
    conversation = {participant_ids: participant_ids}.merge(conversation_params)
    @conversation = Conversation.new(conversation)
    authorize @conversation

    if @conversation.save
      render json: @conversation, status: :created, location: api_v1_conversation_url(@conversation)
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  private 
  def conversation_params
    params.permit(:product_id)
  end
end