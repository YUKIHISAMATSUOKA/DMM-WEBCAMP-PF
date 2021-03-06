require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get payments_index_url
    assert_response :success
  end

  test "should get edit" do
    get payments_edit_url
    assert_response :success
  end

end
