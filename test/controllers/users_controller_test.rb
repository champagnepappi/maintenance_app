require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
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


end
