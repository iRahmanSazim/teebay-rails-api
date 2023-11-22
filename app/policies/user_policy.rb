class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record 
  end

  def index?
    !!user
  end

  def show?
    !!user && user.id == record.id
  end

  def truncate?
    !!user && user.is_admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end