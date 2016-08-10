require 'test_helper'

class RequestsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:santos)
    @non_admin = users(:austin)
  end

  test "requests index" do
    log_in_as(@admin)
    get requests_path
    assert_template 'requests/index'
    unless @admin
      assert_select 'a[href=?]', request_path(request), text: 'Approve'
      assert_select 'a[href=?]', request_path(request), text: 'Reject'
    end
  end
end
