require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @user = users(:santos)
    @request = Request.new(content: "Lorem ipsum", user_id: @user.id)
  end

  test "user id should be present" do
    @request.user_id = nil
    assert_not @request.valid?
  end

  test "request should be at most 140 characters" do
    @request.content = 'a'*201
    assert_not @request.valid?
  end
end
