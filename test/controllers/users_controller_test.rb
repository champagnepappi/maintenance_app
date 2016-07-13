require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
    @other_user = users(:austin)
  end
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

   test "should redirect to home" do
    post users_url, params: {
      user: {
        name: "Me Again",
        email: "me@gmail.com",
        password: "passwd",
        password_confirmation: "passwd"
        
      }
    } 
    assert_redirected_to User.last
    assert_equal "You successfully signed up",flash[:success]
  end

   test "should render new for invalid params" do
     post users_url, params: {
       user: {
         name: " ",
         email: "renado@gmail.com",
         password: "pas",
         password_confirmation: "wor"
       }
     }
     assert_template 'new'
   end

   test "should redirect edit when not logged in" do
     get :edit, id: @user
     assert_not flash.empty?
     assert_redirected_to login_url
   end

   test "should redirect update when not logged in" do
     patch :update, id: @user, user: {
        name: @user.name,
        email: @user.email
     }
     assert_not flash.empty?
     assert_redirected_to login_url
   end

   test "should redirect update when logged in as wrong user" do
     log_in_as(@other_user)
     patch :update, id: @user, user: {
        name: @user.name,
        email: @user.email
     }
     assert flash.empty?
     assert_redirected_to root_url
   end


end
