class Task < ApplicationRecord
  belongs_to :todo_list

  validates :name, presence: true
  validates :completed, inclusion: { in: [true, false] }
end
