require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get projects_dashboard_url
    assert_response :success
  end

end
