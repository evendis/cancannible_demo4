class Role < ActiveRecord::Base
  default_scope { order(:id) }

  include Cancannible::Grantee

end
