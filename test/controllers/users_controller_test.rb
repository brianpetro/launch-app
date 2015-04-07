require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should post create" do
    post :create, user: {email: users(:one).email}
    assert_response :success
  end

end
