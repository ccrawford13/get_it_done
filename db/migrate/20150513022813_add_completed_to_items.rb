class AddCompletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :completed, :boolean, default: false
    add_index :items, :completed
  end
end
