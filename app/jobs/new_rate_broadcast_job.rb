class NewRateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(quote)
    ActionCable.server.broadcast 'rate_channel', rate_data: serialize_rate(quote)
  end

  private

  def serialize_rate(quote)
    QuoteSerializer.new quote
  end
end
