class CustomersController < ApplicationController
  before_filter :authenticate_user!

  # we are asserting access restritions in this controller.
  before_filter :collection

end