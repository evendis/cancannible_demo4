# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


article_readers_group = Group.create(name: 'Article Readers')
general_group = Group.create(name: 'Group Without Special Permissions')

admin_role = Role.create(name: 'Admin Role')
customer_role = Role.create(name: 'Customer Role')

customer_a = Customer.create(name: 'CustomerA')
customer_b = Customer.create(name: 'CustomerB')
customer_c = Customer.create(name: 'CustomerC')

common_user_attrs = { password: 'password', password_confirmation: 'password' }

admin_user    = User.create( common_user_attrs.merge( username: 'admin_user'   , description: 'has access to everything by virtue of their Admin Role' ) )
group_user    = User.create( common_user_attrs.merge( username: 'group_user'   , description: 'has access determined by their group membership', group: article_readers_group ) )
limited_user  = User.create( common_user_attrs.merge( username: 'limited_user' , description: 'has direct permissions assigned (no role or group)' ) )
customer_user = User.create( common_user_attrs.merge( username: 'customer_user', description: 'has access determined by their customer relationship and Customer Role', customer: customer_a ) )

admin_user.roles << admin_role
customer_user.roles << customer_role

article_1 = Article.create( title: 'Any Group or Customer' )
article_2 = Article.create( title: 'Article 1 For Article Readers Group', group: article_readers_group )
article_3 = Article.create( title: 'Article 2 For General Group', group: general_group )
article_4 = Article.create( title: 'For CustomerA', customer: customer_a )
article_5 = Article.create( title: 'For CustomerA or Article Readers', group: article_readers_group, customer: customer_a )

## Define some permissions (these get stored in the database by cancannible)

# anyone with the admin role can see everything
admin_role.can :read, :all

# anyone in the article_readers_group can see articles
article_readers_group.can :read, Article

# anyone with the customer_role can see customer records
customer_role.can :read, Article
customer_role.can :read, Customer

# specific record access
limited_user.can :read, customer_b
limited_user.can :read, article_5