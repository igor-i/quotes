class Admin::ManualRatesController < ApplicationController
  before_action do
    @quote = Quote.find_or_initialize_by(currency_pair: :usd_rub)
  end

  def new
    previous_manual_rate = @quote.manual_rate&.rate
    previous_die_at = @quote.manual_rate&.die_at
    @manual_rate = ManualRate.new(rate: previous_manual_rate, die_at: previous_die_at)
  end

  def create
    @manual_rate = ManualRate.new(params[:manual_rate].permit(:rate, :die_at))

    if @manual_rate.save
      @quote.manual_rate = @manual_rate
      @quote.current_rate = @manual_rate
      @quote.mark_as_manual!
      redirect_to root_url
    else
      render :new
    end
  end
end
