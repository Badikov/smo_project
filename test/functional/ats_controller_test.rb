require 'test_helper'

class AtsControllerTest < ActionController::TestCase
  test "should get create_links" do
    get :create_links
    assert_response :success
  end

  test "should get files" do
    get :files
    assert_response :success
  end

end
