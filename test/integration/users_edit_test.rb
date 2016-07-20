require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user:{
      name: "",
      email: "aiden@g.com",
      contact: "0712345577",
      password: "lesl",
      password_confirmation: "lit"
    }
    }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Jane sharon"
    email = "shaz@g.com"
      contact= "0712345577"
    patch user_path(@user), params: {user:{
      name: name,
      email: email,
      contact: contact,
      password: "",
      password_confirmation: ""
    }
    }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload #reload users info from db to confirm that they are successfully updated
    assert_equal @user.name, name
    assert_equal @user.email, email
    assert_equal @user.contact, contact

  end

  test "friendly forwarding for successful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Just Me"
    email = "me@gmail.com"
      contact= "0712345577"
    patch user_path(@user), params: {user: {
       name: name,
       email: email,
       contact: contact,
       password: "passw",
       password_confirmation: "passw"
    }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
    assert_equal @user.contact, contact
  end
end
