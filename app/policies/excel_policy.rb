class ExcelPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.subscriber?
  end

  def create?
    @user.subscriber?
  end

  def update?
    @user.subscriber?
  end
end
