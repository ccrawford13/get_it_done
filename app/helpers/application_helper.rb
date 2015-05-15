module ApplicationHelper

  # Items with 3 or less days remaining will have text color set to red
  def days_remaining_style(item)
    "#{ item.days_remaining <= 3 ? "item-exp-warning" : "text-muted" }"
  end
end
