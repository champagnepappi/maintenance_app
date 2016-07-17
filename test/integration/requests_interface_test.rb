require 'test_helper'

class RequestsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end

  test "requests interface" do
    log_in_as(@user)
    get root_path
    #invalid submission
    assert_no_difference 'Request.count' do
      post requests_path, params: {request: {content: ""}}
    end
    #valid submission
    content = "This is not the best request you can make"
    assert_difference 'Request.count', 1 do
      post requests_path, params:{request:{ content: content }}
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    #delete request
    assert_select 'a', text: 'delete'
    first_request = @user.requests.first
    assert_difference 'Request.count', -1 do
      delete request_path(first_request)
    end
    #visit different user
    get user_path(users(:sharon))
    assert_select 'a', text: 'delete', count: 0
  end
end
