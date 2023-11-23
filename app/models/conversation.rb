class Conversation < ApplicationRecord
  belongs_to :product
  has_many :messages, dependent: :delete_all
end