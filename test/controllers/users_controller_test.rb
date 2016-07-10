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


end
