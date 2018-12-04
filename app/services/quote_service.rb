# frozen_string_literal: true

class QuoteService
  require 'open-uri'
  require 'json'

  CBR_URL = 'https://www.cbr-xml-daily.ru/daily_json.js'.freeze
  RUN_EVERY = 1.minute

  class << self
    def update_manual_rate!(quote, manual_rate)
      quote.manual_rate = manual_rate
      quote.current_rate = manual_rate
      quote.mark_as_manual!

      Rails.logger.info("Manual updated rates at #{Time.current}")
    end

    def schedule_update_real_rate(quote, wait_time = RUN_EVERY)
      RealRatesUpdateJob.set(wait: wait_time).perform_later(quote)
      Rails.logger.info("Scheduled update rates at #{Time.current + wait_time}")
    end

    def update_real_rate!(quote)
      new_quote = Quote.find(quote.id)

      if (new_quote.current_rate != quote.current_rate)
        Rails.logger.info("Updated rates from CBR is not required at #{Time.current} (outdated job)")
        return
      end

      unless (new_quote.can_update?)
        Rails.logger.info("Updated rates from CBR is not required at #{Time.current} (duration of the manual course)")
        return
      end

      new_quote.start_update!
      Rails.logger.info("Starting update rates from CBR at #{Time.current}")

      response = URI(CBR_URL).open.read
      rates_hash = JSON.parse(response.to_s)
      new_real_rate = RealRate.new(rate: rates_hash['Valute']['USD']['Value'])
      new_real_rate.save!

      new_quote.current_rate = new_real_rate
      new_quote.finish_update!

      rate_data = {
        currency_pair: quote.currency_pair,
        rate: quote.current_rate&.rate,
        updated_at: quote.current_rate&.created_at.to_s,
        state: quote.state
      }

      NewRateBroadcastJob.perform_later(rate_data)
      Rails.logger.info("Finished update rates from CBR at #{Time.current}")

      schedule_update_real_rate(new_quote)
    end
  end
end
