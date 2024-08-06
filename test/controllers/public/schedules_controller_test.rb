require "test_helper"

class Public::SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_schedules_index_url
    assert_response :success
  end

  test "should get show" do
    get public_schedules_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_schedules_edit_url
    assert_response :success
  end
end
