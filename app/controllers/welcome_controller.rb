class WelcomeController < ApplicationController
  def index
    quote = Quote.find_or_initialize_by(currency_pair: :usd_rub)
    @rate_data = {
      currency_pair: quote.currency_pair,
      rate: quote.current_rate&.rate,
      updated_at: quote.current_rate&.created_at,
      state: quote.state
    }
  end
end
