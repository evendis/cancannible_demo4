class CreateUsersRoles < ActiveRecord::Migration
  def change
    create_table :users_roles do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps null: false
    end
  end
end
