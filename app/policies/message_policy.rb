class MessagePolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
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