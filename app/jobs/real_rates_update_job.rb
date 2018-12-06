# frozen_string_literal: true

# :nodoc:
class RealRatesUpdateJob < ApplicationJob
  queue_as :default

  def perform(quote)
    QuoteService.update_real_rate!(quote)
  end
end
