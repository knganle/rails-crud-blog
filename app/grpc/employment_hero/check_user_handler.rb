require 'json'
module RpcHandler
  class CheckUserHandler < BaseHandler
    attr_reader :request, :meta

    def initialize(request, meta)
      @request = request
      @meta = meta
    end

    def call
      user = Admin.find_by(email: request.email)
      puts "Email: #{request.email} - #{user ||= false}"
      if user
        EhProtobuf::EmploymentHero::CheckUserResponse.new(
          accessible: true
        )
      else
        EhProtobuf::NotFoundError.new('Does not Exist')
      end
    end
  end
end
