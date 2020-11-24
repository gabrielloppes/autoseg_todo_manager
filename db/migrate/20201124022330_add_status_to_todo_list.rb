class AddStatusToTodoList < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_lists, :status, :integer
  end
end
