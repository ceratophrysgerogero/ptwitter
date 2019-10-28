require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Home|Ptwitter"
  end

end
