json.extract! todo_list_task, :id, :description, :completed, :completed_at, :todo_list_id, :created_at, :updated_at
json.url todo_list_task_url(todo_list_task, format: :json)
