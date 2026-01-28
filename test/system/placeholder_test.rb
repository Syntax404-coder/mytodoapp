# frozen_string_literal: true

require "application_system_test_case"

class PlaceholderTest < ApplicationSystemTestCase
  test "visiting the health check page" do
    visit rails_health_check_url
    assert_selector "body"
  end
end
