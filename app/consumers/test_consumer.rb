class TestConsumer < Karafka::BaseConsumer
  def consume
    # You can reach the message in the params like in Rails
    puts params.inspect
  end
end
