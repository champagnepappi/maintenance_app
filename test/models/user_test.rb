require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "That Guy", email: "anonymous@gmail.com",
                    password: "passw", password_confirmation: "passw")
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

  test "authenticated? should return false for user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated requests should be destroyed" do
    @user.save
    @user.requests.create!(content: "Lorem ipsum")
    assert_difference 'Request.count', -1 do
      @user.destroy
    end
  end
end

