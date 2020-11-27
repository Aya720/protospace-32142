require 'test_helper'

class ProtospacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get protospaces_index_url
    assert_response :success
  end

end
