require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
  end

  test "when not authenticated, should redirect with alert" do
    get :index
    assert_redirected_to new_user_session_path
    assert_not_nil flash[:alert]
  end

  test "when authenticated, should be allowed to see all permissions anyway (for the purpose of this demo app)" do
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', Group.count
  end

end

