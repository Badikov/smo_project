require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  test "should get upload_xml" do
    get :upload_xml
    assert_response :success
  end

end
