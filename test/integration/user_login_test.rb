require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end
  test "login with incorrect information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {
      name: "",
      password: "ds"
    }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty? #expect flash not to appear in homepage
  end

  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {
      name: @user.name,
      password: 'passw'
    }}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect! #to actually visit the target page
    assert_template 'users/show'
    assert_select "a[href=?]",login_path, count: 0
    assert_select "a[href=?]",logout_path

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]",login_path, count: 0
    assert_select "a[href=?]",logout_path, count: 0


  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
