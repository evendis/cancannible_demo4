class Article < ActiveRecord::Base
  default_scope { order(:id) }
  belongs_to :group
  belongs_to :customer
end
