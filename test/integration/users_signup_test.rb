require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  #verify that exactly one message was deleivered
  def setup
    ActionMailer::Base.deliveries.clear
  end

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
    # assert_redirected_to User.last
    # follow_redirect!
  end
  assert_equal 1, Actionmailer::Base.deliveries.size
  user = assigns(:user)
  assert_not user.activated?
  #login before activation
  log_in_as(user)
  assert_not is_logged_in?
  #invalid activation token
  get edit_account_activation_path("Invalid token")
  assert_not is_logged_in?
  #valid token, wrong email
  get edit_account_activation_path(user.activation_token, email: 'wrong')
  assert_not is_logged_in?
  #valid activation token
  get edit_account_activation_path(user.activation_token, email: user.email)
  assert user.reload.activated?
  follow_redirect!
  assert_template 'users/show'
  assert is_logged_in?


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
