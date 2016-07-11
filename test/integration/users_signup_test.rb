require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

test "sign up with valid params" do
  get new_user_path
  assert_template 'new'
  assert_difference 'User.count',1 do
    post users_path params: {
      user: {
        name: "Kevin Santos",
        email: "santos@gmail.com",
        password: "mypass",
        password_confirmation: "mypass"
      }
    }
    assert_template 'users/show'
    assert_redirected_to User.last
  end
end

test "sign up with invalid params" do
  get new_user_path
  assert_template 'new'
  assert_no_difference 'User.count' do
    post users_path params: {
      user: {
        name: " ",
        email: "kev@c.com",
        password: "pa",
        password_confirmation: "pac"
      }
    }
    assert_template 'new'
  end
end
 
end
