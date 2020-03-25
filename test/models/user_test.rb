require 'test_helper'
class UserTest < ActiveSupport::TestCase

  test "has given name" do
    assert_equal "James", users(:james).given_name
  end
end
