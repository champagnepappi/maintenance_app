require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @common_title = "Maintenance App"
  end
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{@common_title}"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | #{@common_title}"
  end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | #{@common_title}"
  end

end
