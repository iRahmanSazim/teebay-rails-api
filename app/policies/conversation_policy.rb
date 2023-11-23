class ConversationPolicy < ApplicationPolicy
  attr_reader :user, :conversation

  def initialize(user, conversation)
    @user = user
    @conversation = conversation 
  end

  def index?
    !!user
  end

  def show?
    !!user && conversation.participant_ids.include?(user.id)
  end

  def find_messages_by_conversation?
    puts conversation.participant_ids
    !!user && conversation.participant_ids.include?(user.id)
  end

  def create?
    !!user
  end

  def find_by_user?
    !!user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end