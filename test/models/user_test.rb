require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "That Guy", email: "anonymous@gmail.com")
  end
 
  test "name presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name should not be long" do
    @user.name = "x"*41
    assert_not @user.valid?
  end

  test "email should not be long" do
    @user.email = "x"*91 + "@gmail.com"
    assert_not @user.valid?
  end
end
