require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @customer = customers(:one)
    @other_customer = customers(:two)
    @user = users(:one)
  end

  test "when not authenticated, should redirect with alert" do
    get :index
    assert_redirected_to new_user_session_path
    assert_not_nil flash[:alert]
  end

  test "when authenticated but no permissions to customers, should redirect with alert" do
    sign_in @user
    get :index
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
  end

  test "when no customer but full permissions on Customer, they should see all customers" do
    @user.can :read, Customer
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', Customer.count
  end

  test "when full permissions on Customer via Role, they should see all customers" do
    @role = roles(:one)
    @role.can :read, Customer
    @user.roles << @role
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', Customer.count
  end

  test "when full permissions on Customer via Group, they should see all customers" do
    @group = groups(:for_articles)
    @user = users(:group_user)
    @group.can :read, Customer
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', Customer.count
  end

  test "when no customer but limited Customer permissions, they should only see selected customers" do
    @user.can :read, @other_customer
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', {count: 1, text: @other_customer.id.to_s}
  end

  test "when a customer and full Customer permissions, they should only see their own customer record" do
    @user = users(:customer_user)
    @user.can :read, Customer
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', {count: 1, text: @user.customer.id.to_s}
  end


end
