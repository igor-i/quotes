# frozen_string_literal: true

require 'test_helper'

class RealRatesUpdateJobTest < ActiveJob::TestCase
  setup do
    cbr_url = 'https://www.cbr-xml-daily.ru/daily_json.js'
    content = file_fixture('daily_json.js').read
    stub_request(:get, cbr_url).to_return(status: 200, body: content)

    @quote = quotes(:usd_rub)
  end

  test 'must update real rate' do
    assert { @quote.initial? }
    assert { !@quote.current_rate }

    RealRatesUpdateJob.perform_now(@quote)

    @quote.reload
    assert { @quote.updated? }
    assert { @quote.current_rate }
  end

  test 'don\'t must update rate if the manual rate is actually' do
    quote = quotes(:actual_manual)
    current_rate = quote.current_rate
    RealRatesUpdateJob.perform_now(quote)

    quote.reload
    assert { quote.manual? }
    assert { quote.current_rate == current_rate }
  end

  test 'don\'t must update rate if outdated job' do
    quote = quotes(:outdated_manual)
    current_rate = quote.current_rate
    manual_rate = manual_rates(:actual)
    quote.current_rate = manual_rate
    quote.manual_rate = manual_rate

    RealRatesUpdateJob.perform_now(quote)

    quote.reload
    assert { quote.manual? }
    assert { quote.current_rate == current_rate }
  end
end
