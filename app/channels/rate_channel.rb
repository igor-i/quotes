# frozen_string_literal: true

# :nodoc:
class RateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'rate_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(rate_data)
    ActionCable.server.broadcast 'rate_channel', rate: rate_data['rate']
  end
end
