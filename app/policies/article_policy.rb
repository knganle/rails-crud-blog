class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    @user.id == @record.user.id
  end

  def destroy?
    (@user.has_role? :admin) || (@user.id == @record.user.id)
  end
end
