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
end
