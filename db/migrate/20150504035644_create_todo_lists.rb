class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :title
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :todo_lists, :users
    add_index :todo_lists, :title
  end
end
