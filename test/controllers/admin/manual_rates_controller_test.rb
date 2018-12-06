# frozen_string_literal: true

require 'test_helper'

class Admin::ManualRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotes(:usd_rub)
  end

  test '#new' do
    get new_admin_manual_rate_url
    assert_response :success
  end

  test '#create' do
    assert { @quote.initial? }
    assert { !@quote.current_rate }
    assert { !@quote.manual_rate }

    new_rate = 20
    die_at = Time.current + 1.hour

    post admin_manual_rates_url(manual_rate: { rate: new_rate, die_at: die_at })
    assert_response :redirect

    @quote.reload
    assert { @quote.manual? }
    assert { @quote.current_rate.rate == new_rate }
    assert { @quote.manual_rate.rate == new_rate }
  end

  test '#create with past die_at must be false' do
    assert { @quote.initial? }
    assert { !@quote.current_rate }
    assert { !@quote.manual_rate }

    new_rate = 20
    die_at = Time.current - 1.hour

    post admin_manual_rates_url(manual_rate: { rate: new_rate, die_at: die_at })
    assert_response :success

    @quote.reload
    assert { @quote.initial? }
    assert { !@quote.current_rate }
    assert { !@quote.manual_rate }
  end
end
