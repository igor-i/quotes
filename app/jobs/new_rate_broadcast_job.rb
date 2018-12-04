class NewRateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(rate_data)
    ActionCable.server.broadcast 'rate_channel', rate_data: render_rate(rate_data)
  end

  private

  def render_rate(rate_data)
    ApplicationController.renderer.render(partial: 'welcome/rate', locals: rate_data)
  end
end
