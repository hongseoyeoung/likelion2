require 'test_helper'

class SendmailControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sendmail_index_url
    assert_response :success
  end

end
