class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :username,           null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :description

      t.belongs_to :customer
      t.belongs_to :group
      t.timestamps
    end
  end
end
