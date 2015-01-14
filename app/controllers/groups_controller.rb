class GroupsController < ApplicationController
  before_filter :authenticate_user!

  # we do not assert access restritions in this controller;
  # provide a collection method that allows anyone can see all groups
  def collection
    @collection ||= Group.all
  end

end