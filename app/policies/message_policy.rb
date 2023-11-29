class MessagePolicy < ApplicationPolicy
  attr_reader :user, :message
  
  def initialize(user, message)
    @user = user
    @message = message
  end

  def create?
    !!user
  end

  def find_messages_by_conversation?
    !!user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end