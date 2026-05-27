class AddTimestampToTodoList < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :todo_lists, null: true
  end
end
