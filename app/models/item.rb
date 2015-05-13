class Item < ActiveRecord::Base
  belongs_to :todo_list

  validates :todo_list, presence: true
  validates :title, length: { minimum: 5 }, presence: true

  # Scope complete and incomplete items
  scope :incomplete_items, -> { where(completed: false) }
  scope :completed_items, -> { where(completed: true) }

  # Order items in list by created_at or updated_at
  scope :incomplete_and_ordered, -> { incomplete_items.order("created_at DESC") }
  scope :completed_and_ordered, -> { completed_items.order("updated_at DESC") }

  def mark_complete
    self.update_attributes(completed: true)
  end
end
