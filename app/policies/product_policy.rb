class ProductPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record 
  end

  def index?
    !!user
  end

  def create?
    !!user
  end

  def show?
    !!user
  end

  def update?
    !!user && user.id == record.user_id || user.is_admin?
  end

  def destroy?
    !!user && user.id == record.user_id || user.is_admin
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
