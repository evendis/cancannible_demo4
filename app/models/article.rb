class Article < ActiveRecord::Base
  belongs_to :group
  belongs_to :customer
end
