class ArticlePolicy < ApplicationPolicy
  def show?
    # (@user.has_role? :admin) || (@user.id == @record.user.id)
    true
  end

  def update?
    @user.id == @record.user.id
  end

  # def destroy?
  #   (@user.has_role? :admin) || (@user.id == @record.user.id)
  # end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
