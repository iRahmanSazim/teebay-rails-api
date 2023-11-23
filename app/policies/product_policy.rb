class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product 
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
    !!user && user.id == product.user_id || user.is_admin?
  end

  def destroy?
    !!user && user.id == product.user_id || user.is_admin
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
