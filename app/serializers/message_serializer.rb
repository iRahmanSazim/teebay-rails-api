class MessageSerializer < Panko::Serializer
  attributes :id, :conversation_id, :sender_id,  :body, :created_at
end