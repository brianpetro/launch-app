require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should post create" do
    post :create
    assert_response :success
  end

end
