require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "That Guy", email: "anonymous@gmail.com")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email presence" do
    @user.name = " "
    assert_not @user.valid?
  end
end

