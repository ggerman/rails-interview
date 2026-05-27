json.id          @todo_list.id
json.name        @todo_list.name
json.created_at  @todo_list.created_at
json.updated_at  @todo_list.updated_at
json.tasks       @todo_list.tasks do |task|
  json.id          task.id
  json.name        task.name
  json.description task.description
  json.completed   task.completed
  json.created_at  task.created_at
  json.updated_at  task.updated_at
end
