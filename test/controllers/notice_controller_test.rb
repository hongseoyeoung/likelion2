require 'test_helper'

class NoticeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notice_index_url
    assert_response :success
  end

  test "should get create" do
    get notice_create_url
    assert_response :success
  end

  test "should get new" do
    get notice_new_url
    assert_response :success
  end

  test "should get edit" do
    get notice_edit_url
    assert_response :success
  end

  test "should get delete" do
    get notice_delete_url
    assert_response :success
  end

end
