class SendMessagesJob < ApplicationJob
  queue_as :default

  def perform(conversationId, message)
    ActionCable.server.broadcast "message_channel_#{conversationId}", message
  end
end
