class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.references :todo_list, index: true
      t.timestamps null: false
    end
    add_foreign_key :items, :todo_lists
    add_index :items, :title
  end
end
