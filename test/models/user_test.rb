require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User.access_token stores data used to retrieve User object via read_access_token" do
    user = users(:two)
    signature = user.access_token
    assert_equal User.read_access_token(signature), user
  end
end
