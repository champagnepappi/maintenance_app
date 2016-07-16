require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @request = requests(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Request.count' do
      post :create, request: {content: "Lorem ipsum"}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Request.count' do
      delete :destroy, id: @request
    end
    assert_redirected_to login_url
  end
end

 
