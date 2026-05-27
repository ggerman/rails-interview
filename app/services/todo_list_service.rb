class TodoListService
  def self.all
    TodoList.includes(:tasks).order(:id)
  end

  def self.find(id)
    TodoList.includes(:tasks).find(id)
  end

  def self.create(params)
    TodoList.create(params)
  end

  def self.update(id, params)
    todo_list = find(id)
    todo_list.update(params)
    todo_list
  end

  def self.destroy(id)
    find(id).destroy
  end
end
