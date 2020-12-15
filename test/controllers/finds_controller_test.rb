require 'test_helper'

class FindsControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get finds_find_url
    assert_response :success
  end

end
