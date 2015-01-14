class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.belongs_to :group
      t.belongs_to :customer

      t.timestamps null: false
    end
  end
end
