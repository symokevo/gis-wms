require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get water_usage" do
    get reports_water_usage_url
    assert_response :success
  end

  test "should get maintenance_history" do
    get reports_maintenance_history_url
    assert_response :success
  end
end
