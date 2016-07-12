require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user:{
      name: "",
      email: "aiden@g.com",
      password: "lesl",
      password_confirmation: "lit"
    }
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Jane sharon"
    email = "shaz@g.com"
    patch user_path(@user),user:{
      name: name,
      email: email,
      password: "",
      password_confirmation: ""
    }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload #reload users info from db to confirm that they are successfully updated
    assert_equal @user.name, name
    assert_equal @user.email, email

  end
end
