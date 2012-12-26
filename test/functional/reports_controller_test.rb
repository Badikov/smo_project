require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get today" do
    get :today
    assert_response :success
  end

end
