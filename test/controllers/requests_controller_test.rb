require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @request = requests(:one)
    @user = users(:santos)
    @user2 = users(:austin)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Request.count' do
      post requests_path(@user), params:{ request: {content: "Lorem ipsum"}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if not correct user" do
    log_in_as(@user2)
    assert_no_difference 'Request.count' do
      delete request_path(@request), params: { id: @request }
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Request.count' do
      delete request_path(@user), params: {id: @request }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong request" do
    log_in_as(@user)
    request = requests(:wifi)
    assert_no_difference 'Request.count' do
      delete request_path(request), params: {id: request}
    end
    assert_redirected_to root_url
  end
end

 
