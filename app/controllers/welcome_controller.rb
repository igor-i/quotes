class WelcomeController < ApplicationController
  def index
    @quote = Quote.find_or_initialize_by(currency_pair: :usd_rub)
  end
end
