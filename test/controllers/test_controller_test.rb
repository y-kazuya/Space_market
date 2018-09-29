require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get first" do
    get test_first_url
    assert_response :success
  end

end
