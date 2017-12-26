# frozen_string_literal: true

require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should redirect root url" do
    get root_url
    assert_response :redirect
  end
end
