class PermissionsController < ApplicationController
  before_filter :authenticate_user!

  # we do not assert access restritions in this controller;
  # provide a collection method that allows anyone can see all permissions
  def collection
    @collection ||= Permission.all
  end

end