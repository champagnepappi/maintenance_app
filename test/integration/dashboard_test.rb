require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:santos)
    @non_admin = users(:austin)
  end

  test "dashboard" do
    log_in_as(@admin)
    get dashboard_path
    assert_template 'users/dashboard'
    assert_select 'a[href=?]', user_path(@non_admin), text: @non_admin.name
    unless @admin
      assert_select 'a[href=?]',user_path(@non_admin), text: 'Promote to Maintainer'
    end
  end

end
