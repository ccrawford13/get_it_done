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

  # Calculates days remaining till deletion (7 Days from creation)
  def days_remaining
    7 - (DateTime.now.to_date - created_at.to_date).to_i
  end

  def toggle_completed_status
    if self.completed == false
      self.update_attributes(completed: true)
    elsif self.completed == true
      self.update_attributes(completed: false)
    end
  end
end
