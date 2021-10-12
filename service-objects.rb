# Controller
class EasyMathsController < ApplicationController
  def index
    @result = awsome_sum(params[:number_one], params[:number_two])
  end

  private

  def awsome_sum(number_one, number_two)
    number_one.to_f + number_two.to_f
  end
end

# New Controller
class EasyMathsController < ApplicationController
  def index
    @result = EasyMathService.new(params).perform
  end
end

# app/service/easy_math_service.rb
class EasyMathService
  def initialize(params)
    @number_one = params[:number_one]
    @number_two = params[:number_two]
    @operator = params[:operator]
  end

  def perform
    check_condition_math
    do_math
  end

  private

  def check_condition_math
    # check some condition for math
  end

  def do_math
    case @operator
    when 'add'
      # do sth
    when 'sub'
      # do sth
    when 'mutiple'
    #   .....
    else
      'invalid operator'
    end
  end
end
