require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @article = articles(:one)
    @article_for_group = articles(:for_group)
    @user = users(:one)
    @group = groups(:for_articles)
    @group_user = users(:group_user)
  end

  test "when not authenticated, should redirect with alert" do
    get :index
    assert_redirected_to new_user_session_path
    assert_not_nil flash[:alert]
  end

  test "when authenticated but no permissions to articles, should redirect with alert" do
    sign_in @user
    get :index
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
  end

  test "when no group but full permissions on Articles, they should see articles that don't have a group" do
    @user.can :read, Article
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', {count: 1, text: @article.id.to_s}
  end

  test "when no group but Article permissions via Role, they should see articles that don't have a group" do
    @role = roles(:one)
    @role.can :read, Article
    @user.roles << @role
    sign_in @user
    get :index
    assert_response :success
    assert_select 'td.test_id', {count: 1, text: @article.id.to_s}
  end

  test "when has Article permissions and group, they should see group articles and those that don't have a group" do
    @group_user.can :read, Article
    sign_in @group_user
    get :index
    assert_response :success
    assert_select 'td.test_id', 2
    assert_select 'td.test_id', @article.id.to_s
    assert_select 'td.test_id', @article_for_group.id.to_s
  end

  test "when has Article permissions via group, they should see group articles and those that don't have a group" do
    @group.can :read, Article
    sign_in @group_user
    get :index
    assert_response :success
    assert_select 'td.test_id', 2
    assert_select 'td.test_id', @article.id.to_s
    assert_select 'td.test_id', @article_for_group.id.to_s
  end


end
