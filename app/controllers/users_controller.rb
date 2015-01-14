class UsersController < ApplicationController
  before_filter :authenticate_user!

  # we do not assert access restritions in this controller;
  # provide a collection method that allows anyone can see all users
  def collection
    @collection ||= User.all
  end

end