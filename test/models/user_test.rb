require 'test_helper'

class UserWithoutPermissionsTest < ActiveSupport::TestCase

  setup do
    @user = users(:one)
    @article = articles(:one)
    @customer = customers(:one)
  end

  test "should not be able to read Articles" do
    assert !@user.can?(:read, Article)
    assert !@user.can?(:read, @article)
  end

  test "should not be able to read Customers" do
    assert !@user.can?(:read, Customer)
    assert !@user.can?(:read, @customer)
  end

end

class UserWithDirectPermissionsTest < ActiveSupport::TestCase

  setup do
    @user = users(:one)
    @article = articles(:one)
    @customer = customers(:one)
    @user.can :read, Article
    @user.can :read, Customer
  end

  test "should be able to read Articles" do
    assert @user.can?(:read, Article)
    assert @user.can?(:read, @article)
  end

  test "should be able to read Customers" do
    assert @user.can?(:read, Customer)
    assert @user.can?(:read, @customer)
  end

end