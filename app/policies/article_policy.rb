require 'grpc'
require 'snip_services_pb'

class ArticlePolicy < ApplicationPolicy
  def show?
    # (@user.has_role? :admin) || (@user.id == @record.user.id)
    true
  end

  def update?
    @user.id == @record.user.id
  end

  def create?
    stub = Snip::UrlSnipService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    req = Snip::SnipRequest.new(url: @user.email)
    resp_obj = stub.snip_it(req)
    puts "Email: #{req.url} - #{resp_obj.url}"
    resp_obj.url == 'Exists'
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
