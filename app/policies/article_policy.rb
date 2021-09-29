class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def destroy?
      puts 'In destroy --------------- Role admin'
      puts @user.role
      debugger
      @user.has_role? :admin
    end
  end
end
