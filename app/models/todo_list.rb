class TodoList < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, length: { minimum: 5 }, presence: true
end
