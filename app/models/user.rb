class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  belongs_to :group
  belongs_to :customer

  has_many :users_roles, class_name: 'UsersRoles'
  has_many :roles, through: :users_roles

  include Cancannible::Grantee
  inherit_permissions_from :roles, :group

  default_scope { order(:id) }

  class << self

    def options_collection_for_signin
      order(:username).collect{ |u| [u.full_description,u.username] }
    end
  end

  def full_description
    [username,description].compact.join ' - '
  end

  def role_names_list
    roles.collect(&:name).join ', '
  end

  delegate :name, to: :customer,  allow_nil: true, prefix: true
  delegate :name, to: :group,  allow_nil: true, prefix: true

end
