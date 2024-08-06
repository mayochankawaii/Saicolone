require "test_helper"

class Public::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get registrations" do
    get public_homes_registrations_url
    assert_response :success
  end

  test "should get users" do
    get public_homes_users_url
    assert_response :success
  end

  test "should get groups" do
    get public_homes_groups_url
    assert_response :success
  end

  test "should get posts" do
    get public_homes_posts_url
    assert_response :success
  end

  test "should get characters" do
    get public_homes_characters_url
    assert_response :success
  end

  test "should get group_characters" do
    get public_homes_group_characters_url
    assert_response :success
  end

  test "should get schedules" do
    get public_homes_schedules_url
    assert_response :success
  end
end
