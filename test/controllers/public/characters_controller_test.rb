require "test_helper"

class Public::CharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_characters_index_url
    assert_response :success
  end

  test "should get show" do
    get public_characters_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_characters_edit_url
    assert_response :success
  end
end
