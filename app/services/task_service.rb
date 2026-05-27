class TaskService
  def self.all(todo_list_id)
    todo_list_for(todo_list_id).tasks.order(:id)
  end

  def self.find(todo_list_id, task_id)
    todo_list_for(todo_list_id).tasks.find(task_id)
  end

  def self.create(todo_list_id, params)
    todo_list_for(todo_list_id).tasks.create(params)
  end

  def self.update(todo_list_id, task_id, params)
    task = find(todo_list_id, task_id)
    task.update(params)
    task
  end

  def self.destroy(todo_list_id, task_id)
    find(todo_list_id, task_id).destroy
  end

  def self.complete(todo_list_id, task_id)
    task = find(todo_list_id, task_id)
    task.update(completed: true)
    task
  end

  def self.todo_list_for(id)
    TodoList.find(id)
  end
  private_class_method :todo_list_for
end
