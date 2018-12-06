# frozen_string_literal: true

require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  test 'should get current_rate' do
    get current_rate_url
    assert_response :success
  end
end
