# frozen_string_literal: true

# :nodoc:
class QuotesController < ApplicationController
  def current_rate
    quote = Quote.find_or_initialize_by(currency_pair: :usd_rub)
    render json: quote
  end
end
