require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:santos)
    @non_admin = users(:austin)
  end

  test "index as admin and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@admin), text: @admin.name
    unless  @admin
      assert_select 'a[href=?]',user_path(@non_admin),text:'delete',method: :delete
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  # test "index as non-admin" do
  #   log_in_as(@non_admin)
  #   get users_path
  #   assert_select 'a', text: 'delete', count: 0
  # end

end
