require 'json'
class ArticlePolicy < ApplicationPolicy
  def show?
    # (@user.has_role? :admin) || (@user.id == @record.user.id)
    true
  end

  def update?
    @user.id == @record.user.id
  end

  def create?
    response = EhProtobuf::EmploymentHero::Client.check_user({
                                                               email: @user.email
                                                             })
    puts "Email: #{@user.email} - #{response.to_json}"
    puts "Response: #{JSON.pretty_generate(response.to_json)}"
    puts "Has user: #{!response.errors.empty?}"
    puts "Email: #{@user.email} - #{response.result.accessible}"

    response = EhProtobuf::EmploymentHero::Client.check_member_is_approver({
                                                                             approver_id: '7c422706-7058-4479-b3e2-8cbc599496d6'
                                                                           })
    puts "Email: #{@user.email} - #{response.to_json}"
    false
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
