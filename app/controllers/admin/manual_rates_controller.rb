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
      QuoteService.update_manual_rate!(@quote, @manual_rate)

      # NOTE: вообще-то это костыль, нужно только для первого запуска автоматического обновления курса
      wait_time = @manual_rate.die_at - Time.current
      Rails.logger.info("Create manual. wait_time: #{wait_time}")
      QuoteService.schedule_update_real_rate(@quote, wait_time)

      redirect_to root_url
    else
      render :new
    end
  end
end
