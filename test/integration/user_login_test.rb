require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end
  test "login with incorrect information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {
      name: "",
      password: "ds"
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty? #expect flash not to appear in homepage
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {
      name: @user.name,
      password: 'passw'
    }
    assert_redirected_to @user
    follow_redirect! #to actually visit the target page
    assert_template 'users/show'
  end
end
