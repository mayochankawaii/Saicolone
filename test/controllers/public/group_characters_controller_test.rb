require "test_helper"

class Public::GroupCharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_group_characters_index_url
    assert_response :success
  end
end
