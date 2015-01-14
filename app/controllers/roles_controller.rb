class RolesController < ApplicationController
  before_filter :authenticate_user!

  # we do not assert access restritions in this controller;
  # provide a collection method that allows anyone can see all roles
  def collection
    @collection ||= Role.all
  end

end