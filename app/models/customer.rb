class Customer < ActiveRecord::Base
  default_scope { order(:id) }
end
