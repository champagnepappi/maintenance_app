require 'test_helper'

class UserCommentsTest < ActionDispatch::IntegrationTest
  def setup
    @request = requests(:one)
  end

  test "redirect create if not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path params: {
        comment: {
          content: "this is the first comment"
        }
      }
  end
    assert_redirected_to login_url
  end
end
