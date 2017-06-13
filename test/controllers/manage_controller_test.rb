require 'test_helper'

class ManageControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get manage_login_url
    assert_response :success
  end

end
